---
name: cql
description: How to validate and run CQL in this repo using the VS Code CQL extension. Use whenever writing, editing, reviewing, or validating .cql files (input/cql), or CQL snippets in pattern pages, and before claiming any CQL compiles.
---

# CQL validation and execution in cms-qmd

CQL in this repo is validated by the VS Code CQL extension (`cqframework.cql`), which already resolves
the model infos (`USQualityCore 0.5.0`, `USCore 6.1.0-derived`, `FHIR 4.0.1`) and the library
dependencies in `~/.fhir/packages`. Always use it. **Never build or run a standalone CQL translator**
(from `~/.m2` jars, the extension's `cql-ls-server-*.jar`, or anything else); that path has failed
repeatedly on classpath and model info resolution.

## Checking for errors

1. Load the diagnostics tool. It is deferred, so fetch its schema first:
   `ToolSearch` with query `select:mcp__claude-vscode__getDiagnostics`.
2. Call `mcp__claude-vscode__getDiagnostics` with the file's URI, e.g.
   `file:///c:/Users/Bryn/Documents/Src/CQF/cms-qmd/input/cql/CQMElements.cql`.
   Omit `uri` to get every file the editor currently has diagnostics for.
3. Treat `Error` severity as blocking. Read `Warning`s too; they often flag real mistakes.
4. Do not report a CQL change as done, or as compiling, until diagnostics for every file you touched
   come back with no errors.

Notes:
- Edits made with the **Edit** tool trigger re-analysis, and their diagnostics are often attached to
  the tool result automatically.
- After edits made from a shell (sed, Python, heredocs) the diagnostics can be **stale**: the giveaway
  is ranges on lines past `linesInFile`, or errors in code that no longer exists. Make any small edit
  with the Edit tool to force re-analysis, then query again.
- An empty list for a file the editor has not analysed does not mean it is clean. If a file is missing
  from the results, ask the user to open it.
- A change to a library can break the libraries that include it. After editing a shared library
  (`CQMConcepts`, `CQMElements`, `CQMCommon`, `FHIRBuilders`, ...), also check the libraries that
  include it, such as the matching `*Tests.cql` library.

### Fallback

If `mcp__claude-vscode__getDiagnostics` is not available (the session is not running inside the VS
Code extension), ask the user what the Problems panel shows, naming each file exactly. Do not guess,
and do not fall back to a standalone translator.

## Running CQL

Claude cannot evaluate CQL in this repo. The user runs the extension's **Execute CQL** command; results
are written to `input/tests/results/<Library>.txt`, one `<define>=<value>` line per expression. Read
that file after the user says they have run it.

- Patient test data: `input/tests/<Library>/<patient-id>/` (FHIR resource JSON).
- Terminology: the extension reads value sets from `input/vocabulary/valueset` and its sub-directories,
  and code systems from `input/vocabulary/codesystem`. VSAC value sets (with expansions) live in
  `input/vocabulary/valueset/external/`, named `ValueSet-<oid>-<date>.json`. Look there to confirm a
  code is a member of a value set before using it in test fixtures. The top-level `valueset` folder is
  an IG publisher `path-resource`, so anything placed directly in it gets published; check with the
  user before adding ValueSet resources there.
- Test libraries are named `<Library>Tests.cql` and use `define Test...: <Boolean>` expressions that
  evaluate to `true` when they pass.

## CQL mistakes that have come up here

- A function invocation used as a query source needs parentheses: `(F(x)) X where ...`, not
  `F(x) X where ...`. The same applies to fluent calls: `(E.includedEncounters()) I`.
- A string literal that matches a define's name triggers a "String literal ... matches the
  identifier" warning, so avoid listing test names as strings.
- Model elements are FHIR types (`FHIR.id`, `FHIR.string`, `FHIR.EncounterStatus`, `FHIR.Period`).
  Any library written against FHIR (or a model derived from it) must include FHIRHelpers
  (`include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'`), which supplies the implicit conversions from
  FHIR types to CQL system types. Rely on those conversions and write `E.id = 'x'`,
  `E.status = 'finished'`, `start of E.period`, rather than reaching for `.value`.
- An empty list literal needs a type: `List<USQualityCore.Encounter>{}`.
- FHIR status codes are lowercase (`'finished'`, not `'Finished'`), and string literals take single
  quotes; double quotes are identifiers.
- Before declaring a fluent function locally, check whether FHIRCommon, USCoreCommon, or CQMCommon
  already ships it.
