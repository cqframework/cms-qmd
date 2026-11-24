"""Generate the Declaration Index section of input/pagecontent/reference.md.

Parses the public declarations of every shared library listed on the Shared Library Reference page, finds
the sections of this guide's pages that use each one, and rewrites the table between the
BEGIN/END GENERATED DECLARATION INDEX markers in reference.md.

Sources:
  * libraries published in an implementation guide are read from the FHIR package cache
    (~/.fhir/packages), so the guide's dependencies must have been loaded by a build first;
  * the MADiE libraries are read from this guide's convenience copies in input/cql.

Usage: python scripts/gen_decl_index.py [--packages <path to the FHIR package cache>]

The Description column is the @description of each declaration. Where there is none, a summary is taken
from scripts/declaration_summaries.json (keyed 'Library|name'), or, for terminology and parameter
declarations, made from the declaration itself; summaries are shown in italics. The script lists any
declaration with neither, and any summary whose declaration no longer exists.

When a library changes version, or a library is added, update LIBS (and PACKAGES) below and the
Shared Library Index table on the page.
"""
import argparse, base64, html, json, os, re
from collections import defaultdict

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
args = argparse.ArgumentParser(description=__doc__.splitlines()[0])
args.add_argument('--packages', default=os.path.join(os.path.expanduser('~'), '.fhir', 'packages'),
                  help='path to the FHIR package cache')
ARGS = args.parse_args()

# ---------------------------------------------------------------------------------------------------
# CQL declaration parser
# ---------------------------------------------------------------------------------------------------


DECL_RE = re.compile(
    r'^define\s+(?:(public|private)\s+)?(fluent\s+)?function\s+("[^"]+"|[A-Za-z_]\w*)\s*\(',
    re.M)
EXPR_RE = re.compile(r'^define\s+(?:(public|private)\s+)?("[^"]+"|[A-Za-z_]\w*)\s*:', re.M)
OTHER_RE = re.compile(
    r'^(?:(public|private)\s+)?(parameter|codesystem|valueset|code|concept)\s+("[^"]+"|[A-Za-z_]\w*)',
    re.M)

KINDS = {'parameter': 'Parameter', 'codesystem': 'Code system', 'valueset': 'Value set',
         'code': 'Code', 'concept': 'Concept'}


def strip_comments(text):
    """Blank out block and line comments, preserving offsets and newlines; leaves strings intact."""
    out = list(text)
    i, n = 0, len(text)
    in_str = None
    while i < n:
        c = text[i]
        if in_str:
            if c == '\\':
                i += 2
                continue
            if c == in_str:
                in_str = None
            i += 1
            continue
        if c in ('"', "'", '`'):
            in_str = c
            i += 1
            continue
        if text.startswith('/*', i):
            j = text.find('*/', i + 2)
            j = n if j < 0 else j + 2
            for k in range(i, j):
                if out[k] != '\n':
                    out[k] = ' '
            i = j
            continue
        if text.startswith('//', i):
            j = text.find('\n', i)
            j = n if j < 0 else j
            for k in range(i, j):
                out[k] = ' '
            i = j
            continue
        i += 1
    return ''.join(out)


def split_params(s):
    parts, depth, cur = [], 0, ''
    for ch in s:
        if ch in '<(':
            depth += 1
        elif ch in '>)':
            depth -= 1
        if ch == ',' and depth == 0:
            parts.append(cur)
            cur = ''
        else:
            cur += ch
    if cur.strip():
        parts.append(cur)
    return parts


def param_types(params):
    types = []
    for p in split_params(params):
        p = ' '.join(p.split())
        m = re.match(r'("[^"]+"|\w+)\s+(.*)', p)
        types.append(m.group(2) if m else p)
    return types


def parse(text):
    """Return a list of dicts: name, kind, line, types, access, description."""
    clean = strip_comments(text.replace('\r\n', '\n'))
    raw = text.replace('\r\n', '\n')
    decls = []

    def line_of(pos):
        return clean.count('\n', 0, pos) + 1

    def description_before(pos):
        # the @description of the /* */ comment immediately preceding the declaration
        before = raw[:pos].rstrip()
        if not before.endswith('*/'):
            return ''
        start = before.rfind('/*')
        block = before[start + 2:-2]
        m = re.search(r'@description:\s*(.*?)(?=\n\s*@\w+:|\Z)', block, re.S)
        return ' '.join(m.group(1).split()) if m else ''

    for m in DECL_RE.finditer(clean):
        # read the parameter list up to the matching paren
        i, depth = m.end(), 1
        while depth and i < len(clean):
            if clean[i] == '(':
                depth += 1
            elif clean[i] == ')':
                depth -= 1
            i += 1
        params = clean[m.end():i - 1]
        decls.append(dict(name=m.group(3), kind='Fluent function' if m.group(2) else 'Function',
                          line=line_of(m.start()), types=param_types(params),
                          access=m.group(1) or 'public', description=description_before(m.start())))
    for m in EXPR_RE.finditer(clean):
        if m.group(2) in ('function', 'fluent'):
            continue
        decls.append(dict(name=m.group(2), kind='Expression', line=line_of(m.start()), types=None,
                          access=m.group(1) or 'public', description=description_before(m.start())))
    for m in OTHER_RE.finditer(clean):
        decls.append(dict(name=m.group(3), kind=KINDS[m.group(2)], line=line_of(m.start()), types=None,
                          access=m.group(1) or 'public', description=description_before(m.start()),
                          source=' '.join(clean[m.start():clean.find('\n', m.start())].split())))
    decls.sort(key=lambda d: d['line'])
    return decls


# ---------------------------------------------------------------------------------------------------
# Declaration index
# ---------------------------------------------------------------------------------------------------

PAGES = os.path.join(ROOT, 'input', 'pagecontent')
LOCAL = os.path.join(ROOT, 'input', 'cql')
GH_LOCAL = 'https://github.com/cqframework/cms-qmd/blob/main/input/cql/'

PACKAGES = {
    'FHIRHelpers': 'hl7.fhir.uv.cql#2.0.0',
    'FHIRCommon': 'hl7.fhir.uv.cql#2.0.0',
    'USCoreCommon': 'hl7.fhir.us.cql#2.0.0',
    'USCoreElements': 'hl7.fhir.us.cql#2.0.0',
    'CumulativeMedicationDuration': 'hl7.fhir.us.cql#2.0.0',
    'USQualityCoreCommon': 'fhir.onc.us-quality-core#0.5.0',
}


def from_package(lib):
    path = os.path.join(ARGS.packages, PACKAGES[lib], 'package', f'Library-{lib}.json')
    for c in json.load(open(path, encoding='utf-8')).get('content', []):
        if c.get('contentType') == 'text/cql':
            return base64.b64decode(c['data']).decode('utf-8')
    raise SystemExit(f'No CQL content in {path}')


def from_file(path):
    return lambda: open(path, encoding='utf-8').read()


# library: (source loader, definition link base, link by line?)
LIBS = {
    'FHIRHelpers': (lambda: from_package('FHIRHelpers'), '{{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html', False),
    'FHIRCommon': (lambda: from_package('FHIRCommon'), '{{site.data.fhir.ver.cql}}/Library-FHIRCommon.html', False),
    'USCoreCommon': (lambda: from_package('USCoreCommon'), '{{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html', False),
    'USCoreElements': (lambda: from_package('USCoreElements'), '{{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html', False),
    'CumulativeMedicationDuration': (lambda: from_package('CumulativeMedicationDuration'), '{{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html', False),
    'USQualityCoreCommon': (lambda: from_package('USQualityCoreCommon'), 'https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html', False),
}
for lib in ['CQMCommon', 'CQMConcepts', 'CQMElements', 'CQMInferences', 'ClaimCommon', 'ClaimElements',
            'MedicationCommon', 'FHIRBuilders', 'SupplementalDataElements']:
    LIBS[lib] = (from_file(os.path.join(LOCAL, lib + '.cql')), GH_LOCAL + lib + '.cql', True)

# Pages scanned for usage, with their titles; migration and administrative pages are excluded
EXCLUDE = {'refactored_index.md', 'reference.md', 'pattern_index.md', 'patterns.md', 'changes.md', 'index.md', 'license.md', 'change_control.md'}
xml = open(os.path.join(ROOT, 'input', 'cms-qmd.xml'), encoding='utf-8').read()
TITLES = dict(re.findall(r'<nameUrl value="([^"]+)\.html"/>\s*<title value="([^"]+)"/>', xml))

# where a name is defined in several libraries and the call is not qualified, the page's own library wins
AFFINITY = {
    'pattern_medications': ['MedicationCommon'],
    'pattern_claim': ['ClaimCommon', 'ClaimElements'],
    'pattern_billingrelated': ['ClaimCommon', 'ClaimElements'],
    'pattern_encounters': ['CQMElements'],
}

COLLAPSE = 4  # more overloads than this in one library are summarized as a count

# Summaries for declarations with no @description, keyed 'Library|name'
SUMMARIES = json.load(open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'declaration_summaries.json'),
                           encoding='utf-8'))


def terminology_summary(d):
    """A summary of a code system, value set, code, concept, or parameter, from its declaration."""
    src = d.get('source', '')
    if d['kind'] == 'Code':
        m = re.search(r""":\s*'([^']*)'\s+from\s+("[^"]+"|\w+)(?:\s+display\s+'([^']*)')?""", src)
        if m:
            text = f'Code `{m.group(1)}` from {m.group(2)}'
            return text + (f' ({m.group(3)})' if m.group(3) else '') + '.'
    if d['kind'] in ('Code system', 'Value set'):
        m = re.search(r":\s*'([^']*)'(?:\s+version\s+'([^']*)')?", src)
        if m:
            return f'{d["kind"]} `{m.group(1)}`' + (f', version `{m.group(2)}`' if m.group(2) else '') + '.'
    if d['kind'] == 'Parameter':
        m = re.match(r'parameter\s+(?:"[^"]+"|\w+)\s*(.*?)(?:\s+default\s+(.*))?$', src)
        if m:
            text = f'Parameter of type `{m.group(1)}`' if m.group(1) else 'Parameter'
            return text + (f', defaulting to `{m.group(2)}`' if m.group(2) else '') + '.'
    if d['kind'] == 'Concept' and ':' in src:
        return 'Concept made up of ' + src.split(':', 1)[1].strip() + '.'
    return ''


def cell(text):
    """Escape text for a markdown table cell, leaving code spans alone."""
    parts = text.split('`')
    for i in range(0, len(parts), 2):
        parts[i] = parts[i].replace('<', '&lt;').replace('>', '&gt;')
    return '`'.join(parts).replace('|', '\\|')


def description(lib, name, ds):
    """The @description of the declaration, otherwise a summary in italics."""
    descs = []
    for d in (ds if len(ds) <= COLLAPSE else ds[:1]):
        if d['description'] and d['description'] not in descs:
            descs.append(d['description'])
    if descs:
        return '<br/>'.join(cell(x) for x in descs)
    summary = SUMMARIES.get(f'{lib}|{name}') or terminology_summary(ds[0])
    return f'_{cell(summary)}_' if summary else ''


def kramdown_id(text, seen):
    text = re.sub(r'\[([^\]]*)\]\([^)]*\)', r'\1', text)
    text = re.sub(r'<[^>]+>', '', text)
    text = re.sub(r'&\w+;', '', text)
    t = text.lower()
    t = re.sub(r'[^a-z0-9 _-]', '', t)
    t = re.sub(r'^[^a-z]+', '', t)
    t = t.replace(' ', '-')
    base = t or 'section'
    n = seen.get(base, 0)
    seen[base] = n + 1
    return base if n == 0 else f'{base}-{n}'


def sections():
    """Yield (page, page title, heading, anchor, text) for each ###/#### section of each page."""
    for fn in sorted(os.listdir(PAGES)):
        if not fn.endswith('.md') or fn.startswith('_') or fn in EXCLUDE:
            continue
        page = fn[:-3]
        title = TITLES.get(page, page)
        seen = {}
        heading, anchor, buf = None, None, []
        in_code = False
        for line in open(os.path.join(PAGES, fn), encoding='utf-8'):
            if line.startswith('```'):
                in_code = not in_code
            m = None if in_code else re.match(r'^(#{2,5})\s+(.*?)\s*(\{#([\w-]+)\})?\s*$', line)
            if m:
                yield page, title, heading, anchor, ''.join(buf)
                heading = re.sub(r'\[([^\]]*)\]\([^)]*\)', r'\1', m.group(2)).replace('`', '').rstrip(':')
                anchor = m.group(4) or kramdown_id(m.group(2).replace('`', ''), seen)
                buf = []
            else:
                buf.append(line)
        yield page, title, heading, anchor, ''.join(buf)


def main():
    decls = defaultdict(list)  # (name, library) -> [decl]
    definers = defaultdict(set)  # name -> libraries
    for lib, (load, base, lines) in LIBS.items():
        for d in parse(load()):
            if d['access'] != 'public':
                continue
            decls[(d['name'], lib)].append(d)
            definers[d['name']].add(lib)

    usage = defaultdict(list)  # (name, library) -> [(label, link)]
    libnames = set(LIBS)
    for page, title, heading, anchor, text in sections():
        mentioned = {l for l in libnames if re.search(r'\b' + l + r'\b', text)}
        link = f'{page}.html' + (f'#{anchor}' if anchor else '')
        label = f'{title}: {heading}' if heading else title
        for name, libs in definers.items():
            quoted = name.startswith('"')
            # functions are matched by call syntax, everything else by its (quoted) name
            is_fn = any(d['types'] is not None for l in libs for d in decls[(name, l)])
            if is_fn:
                pat = r'(?<![\w"])(?:(\w+)\.)?' + re.escape(name) + r'\('
            elif quoted:
                pat = r'(?:(\w+)\.)?' + re.escape(name)
            else:
                pat = r'(?:(\w+)\.)?\b' + re.escape(name) + r'\b(?!\()'
                if len(name) < 6:  # short unquoted identifiers (codes, parameters) are too noisy
                    continue
            hits = list(re.finditer(pat, text))
            if not hits:
                continue
            found = set()
            for h in hits:
                q = h.group(1)
                if q in libs:
                    found.add(q)
                elif len(libs) == 1:
                    found |= libs
                else:
                    preferred = [l for l in AFFINITY.get(page, []) if l in libs]
                    if preferred:
                        found.add(preferred[0])
                        continue
                    counts = {l: len(re.findall(r'\b' + l + r'\b', text)) for l in libs & mentioned}
                    if counts:  # the library the section names most often
                        top = max(counts.values())
                        found |= {l for l, c in counts.items() if c == top}
                    # ambiguous and no library named in the section: not attributed
            for l in found:
                if (label, link) not in usage[(name, l)]:
                    usage[(name, l)].append((label, link))

    def sortkey(k):
        name, lib = k
        return (name.strip('"').lower(), name.strip('"'), lib.lower())

    groups = defaultdict(list)
    for k in sorted(decls, key=sortkey):
        initial = k[0].strip('"')[0].upper()
        groups[initial if initial.isalpha() else '#'].append(k)

    out, missing = [], []
    letters = sorted(groups)
    out.append(' | '.join(f'[{c}](#declarations-{c.lower()})' for c in letters))
    out.append('')
    for c in letters:
        out.append(f'#### {c} {{#declarations-{c.lower()}}}')
        out.append('')
        out.append('| Declaration | Kind | Library | Description | Discussed in |')
        out.append('|----|----|----|----|----|')
        for k in groups[c]:
            name, lib = k
            ds = decls[k]
            _, base, lines = LIBS[lib]
            def ref(d):
                return base + (f'#L{d["line"]}' if lines else '')
            kind = ds[0]['kind']
            if ds[0]['types'] is not None:
                if len(ds) > COLLAPSE:
                    decl = f'[`{name}()`]({ref(ds[0])}) ({len(ds)} overloads)'
                else:
                    decl = '<br/>'.join(f'[`{name}({", ".join(d["types"])})`]({ref(d)})' for d in ds)
            else:
                decl = f'[`{name}`]({ref(ds[0])})'
            decl = decl.replace('|', '\\|')
            if any(d['description'].startswith('TESTING SUPPORT') for d in ds) or name.startswith('"TESTING SUPPORT'):
                kind += ' (testing support)'
            used = '<br/>'.join(f'[{html.escape(lbl, quote=False)}]({lnk})' for lbl, lnk in usage.get(k, []))
            desc = description(lib, name, ds)
            if not desc:
                missing.append(f'{lib}|{name}')
            out.append(f'| {decl} | {kind} | {lib} | {desc} | {used} |')
        out.append('{: .grid}')
        out.append('')

    page = os.path.join(PAGES, 'reference.md')
    s = open(page, encoding='utf-8').read()
    begin, end = '<!-- BEGIN GENERATED DECLARATION INDEX -->', '<!-- END GENERATED DECLARATION INDEX -->'
    i, j = s.index(begin) + len(begin), s.index(end)
    s = s[:i] + '\n' + '\n'.join(out) + '\n' + s[j:]
    open(page, 'w', encoding='utf-8', newline='\n').write(s)
    total = sum(len(v) for v in decls.values())
    print(f'{total} declarations, {len(decls)} rows, {sum(1 for k in decls if usage.get(k))} with usage links')
    unused = sorted(set(SUMMARIES) - {f'{lib}|{name}' for name, lib in decls})
    if missing:
        print('No @description or summary (add to declaration_summaries.json):', *missing, sep='\n  ')
    if unused:
        print('Summaries for declarations that no longer exist:', *unused, sep='\n  ')


if __name__ == '__main__':
    main()
