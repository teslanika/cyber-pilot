# Feature: SDLC Kit & Artifact Pipeline


<!-- toc -->

- [1. Feature Context](#1-feature-context)
  - [1. Overview](#1-overview)
  - [2. Purpose](#2-purpose)
  - [3. Actors](#3-actors)
  - [4. References](#4-references)
- [2. Actor Flows (CDSL)](#2-actor-flows-cdsl)
  - [Artifact Pipeline Guidance](#artifact-pipeline-guidance)
  - [Self-Check](#self-check)
- [3. Processes / Business Logic (CDSL)](#3-processes-business-logic-cdsl)
  - [Resolve Pipeline Position](#resolve-pipeline-position)
  - [Validate Kit Completeness](#validate-kit-completeness)
- [4. States (CDSL)](#4-states-cdsl)
  - [Pipeline Position](#pipeline-position)
- [5. Definitions of Done](#5-definitions-of-done)
  - [Kit File Coverage](#kit-file-coverage)
  - [Pipeline Completeness](#pipeline-completeness)
  - [Generated Output Integrity](#generated-output-integrity)
  - [Self-Check Command](#self-check-command)
- [6. Implementation Modules](#6-implementation-modules)
- [7. Acceptance Criteria](#7-acceptance-criteria)

<!-- /toc -->

- [x] `p1` - **ID**: `cpt-cypilot-featstatus-sdlc-kit`

## 1. Feature Context

- [x] `p1` - `cpt-cypilot-feature-sdlc-kit`

### 1. Overview

The SDLC kit delivers the primary domain content for Cypilot — per-artifact files (rules, templates, checklists, examples) for PRD, DESIGN, ADR, DECOMPOSITION, and FEATURE artifact kinds, plus codebase review files. The kit ships as a direct file package; all files are maintained as ready-to-use resources. The kit also provides pipeline guides (greenfield, brownfield, monolith) and a self-check command for verifying kit integrity.

### 2. Purpose

Without SDLC-specific content, Cypilot is a generic ID system with no domain value. This kit provides the artifact-first development methodology — PRD → DESIGN → ADR → DECOMPOSITION → FEATURE → CODE — that is Cypilot's primary use case. Addresses PRD requirements for an artifact pipeline (`cpt-cypilot-fr-sdlc-pipeline`) and an SDLC kit package (`cpt-cypilot-fr-sdlc-plugin`).

### 3. Actors

| Actor | Role in Feature |
|-------|-----------------|
| `cpt-cypilot-actor-user` | Customizes kit files, runs self-check, follows pipeline guides |
| `cpt-cypilot-actor-ai-agent` | Generates artifacts using kit templates/rules/checklists, follows pipeline ordering |
| `cpt-cypilot-actor-cypilot-cli` | Executes self-check validation, resolves pipeline context |

### 4. References

- **PRD**: [PRD.md](../PRD.md) — `cpt-cypilot-fr-sdlc-pipeline`, `cpt-cypilot-fr-sdlc-plugin`
- **Design**: [DESIGN.md](../DESIGN.md) — `cpt-cypilot-component-sdlc-plugin`
- **Dependencies**: `cpt-cypilot-feature-blueprint-system`, `cpt-cypilot-feature-traceability-validation`

## 2. Actor Flows (CDSL)

### Artifact Pipeline Guidance

- [x] `p1` - **ID**: `cpt-cypilot-flow-sdlc-kit-pipeline`

**Actor**: `cpt-cypilot-actor-ai-agent`

**Success Scenarios**:
- Agent determines which artifact to generate next based on existing artifacts → suggests correct `cypilot generate <KIND>` command
- Greenfield project: agent starts with PRD, then DESIGN, then ADR/DECOMPOSITION/FEATURE
- Brownfield project: agent starts with reverse-engineering, then generates DESIGN from existing code

**Error Scenarios**:
- No system registered in `artifacts.toml` → error with hint to run `cpt init`
- Kit not installed → error with hint to install SDLC kit

**Steps**:
1. [x] - `p1` - Agent invokes pipeline guidance (triggered by generate workflow or user request) - `inst-invoke-pipeline`
2. [x] - `p1` - Load registered artifacts for the target system from `artifacts.toml` - `inst-load-artifacts`
3. [x] - `p1` - Resolve pipeline position using `cpt-cypilot-algo-sdlc-kit-resolve-pipeline` - `inst-resolve-position`
4. [x] - `p1` - **IF** no artifacts exist - `inst-if-no-artifacts`
   1. [x] - `p1` - Detect project type: GREENFIELD (no source code) or BROWNFIELD (source code exists) - `inst-detect-project-type`
   2. [x] - `p1` - **IF** GREENFIELD **RETURN** suggest starting with PRD - `inst-if-greenfield`
   3. [x] - `p1` - **IF** BROWNFIELD **RETURN** suggest reverse-engineering then DESIGN - `inst-if-brownfield`
5. [x] - `p1` - **RETURN** next artifact kind to generate with rationale - `inst-return-next`

### Self-Check

- [x] `p1` - **ID**: `cpt-cypilot-flow-sdlc-kit-self-check`

**Actor**: `cpt-cypilot-actor-user`

**Success Scenarios**:
- User runs `cpt self-check` → all kit files verified, PASS with coverage report

**Error Scenarios**:
- Kit files missing → FAIL with list of missing files

**Steps**:
1. [x] - `p1` - User invokes `cpt self-check` - `inst-user-self-check`
2. [x] - `p1` - Load installed kits from `{cypilot_path}/config/core.toml` - `inst-load-kits`
3. [x] - `p1` - **FOR EACH** installed kit - `inst-foreach-kit`
   1. [x] - `p1` - Validate kit completeness using `cpt-cypilot-algo-sdlc-kit-validate-completeness` - `inst-validate-kit`
4. [x] - `p1` - Aggregate results across all kits - `inst-aggregate-results`
5. [x] - `p1` - **IF** any kit fails **RETURN** FAIL with per-kit details - `inst-if-fail`
6. [x] - `p1` - **RETURN** PASS with coverage summary (kits checked, artifact kinds found, files verified) - `inst-return-pass`

## 3. Processes / Business Logic (CDSL)

### Resolve Pipeline Position

- [x] `p1` - **ID**: `cpt-cypilot-algo-sdlc-kit-resolve-pipeline`

**Input**: List of registered artifacts for a system (paths, kinds, traceability settings)

**Output**: Pipeline status: present artifact kinds, missing artifact kinds, recommended next kind with rationale

**Steps**:
1. [x] - `p1` - Define pipeline ordering: PRD → DESIGN → ADR → DECOMPOSITION → FEATURE - `inst-define-ordering`
2. [x] - `p1` - Classify each registered artifact by kind - `inst-classify-artifacts`
3. [x] - `p1` - Identify present kinds (have at least one registered artifact) and missing kinds - `inst-identify-present-missing`
4. [x] - `p1` - **FOR EACH** missing kind in pipeline order - `inst-foreach-missing`
   1. [x] - `p1` - Check if dependencies are satisfied (PRD before DESIGN, DESIGN before FEATURE, etc.) - `inst-check-dependencies`
   2. [x] - `p1` - **IF** dependencies satisfied **RETURN** this kind as recommended next step - `inst-if-deps-satisfied`
5. [x] - `p1` - **IF** all kinds present **RETURN** pipeline complete, suggest CODE implementation - `inst-if-all-present`
6. [x] - `p1` - **RETURN** pipeline status with present, missing, and recommendation - `inst-return-status`

### Validate Kit Completeness

- [x] `p1` - **ID**: `cpt-cypilot-algo-sdlc-kit-validate-completeness`

**Input**: Kit slug, path to kit's installed directory

**Output**: Validation result: PASS/FAIL with details per artifact kind

**Steps**:
1. [x] - `p1` - Define expected artifact kinds for SDLC kit: PRD, DESIGN, ADR, DECOMPOSITION, FEATURE - `inst-define-expected`
2. [x] - `p1` - Define expected codebase outputs: `codebase/rules.md`, `codebase/checklist.md` - `inst-define-codebase`
3. [x] - `p1` - **FOR EACH** expected artifact kind - `inst-foreach-kind`
   1. [x] - `p1` - Check that output directory `{cypilot_path}/config/kits/{slug}/artifacts/{KIND}/` exists - `inst-check-output-dir`
   2. [x] - `p1` - Check required files present: `rules.md`, `checklist.md`, `template.md` - `inst-check-required-files`
   3. [x] - `p1` - **IF** any required file missing, record as FAIL for this kind - `inst-if-missing-file`
4. [x] - `p1` - Check kit-wide `constraints.toml` exists at `{cypilot_path}/config/kits/{slug}/constraints.toml` - `inst-check-constraints`
5. [x] - `p1` - Check codebase outputs exist - `inst-check-codebase`
6. [x] - `p1` - **IF** any check failed **RETURN** FAIL with list of missing files - `inst-if-any-fail`
7. [x] - `p1` - **RETURN** PASS with coverage (kinds verified, files checked) - `inst-return-valid`

## 4. States (CDSL)

### Pipeline Position

- [x] `p1` - **ID**: `cpt-cypilot-state-sdlc-kit-pipeline-position`

**States**: EMPTY, REQUIREMENTS, DESIGNED, DECOMPOSED, SPECIFIED, COMPLETE

**Initial State**: EMPTY

**Transitions**:
1. [x] - `p1` - **FROM** EMPTY **TO** REQUIREMENTS **WHEN** PRD artifact is registered for the system - `inst-prd-registered`
2. [x] - `p1` - **FROM** REQUIREMENTS **TO** DESIGNED **WHEN** DESIGN artifact is registered - `inst-design-registered`
3. [x] - `p1` - **FROM** DESIGNED **TO** DECOMPOSED **WHEN** DECOMPOSITION artifact is registered - `inst-decomposition-registered`
4. [x] - `p1` - **FROM** DECOMPOSED **TO** SPECIFIED **WHEN** at least one FEATURE artifact is registered - `inst-feature-registered`
5. [x] - `p1` - **FROM** SPECIFIED **TO** COMPLETE **WHEN** all features in DECOMPOSITION have FEATURE artifacts - `inst-all-features`

> Kit lifecycle state (UNINSTALLED → INSTALLED → OUTDATED) is owned by `cpt-cypilot-feature-blueprint-system` (kit management feature).

## 5. Definitions of Done

### Kit File Coverage

- [x] `p1` - **ID**: `cpt-cypilot-dod-sdlc-kit-blueprint-coverage`

The SDLC kit **MUST** provide per-artifact files for all five artifact kinds (PRD, DESIGN, ADR, DECOMPOSITION, FEATURE) and codebase files. Each artifact kind **MUST** have: `rules.md`, `template.md`, `checklist.md`, and `examples/example.md`. The kit **MUST** include a `SKILL.md` for AI agent discoverability and workflow files in `workflows/` for generate/analyze operations.

**Implements**:
- `cpt-cypilot-flow-sdlc-kit-pipeline`

**Covers (PRD)**:
- `cpt-cypilot-fr-sdlc-plugin`

**Covers (DESIGN)**:
- `cpt-cypilot-component-sdlc-plugin`
- `cpt-cypilot-principle-kit-centric`

### Pipeline Completeness

- [x] `p1` - **ID**: `cpt-cypilot-dod-sdlc-kit-pipeline`

The SDLC kit **MUST** support the artifact-first pipeline: PRD → DESIGN → ADR → DECOMPOSITION → FEATURE → CODE. Each artifact kind **MUST** be usable independently (no forced sequence). The kit **MUST** support both greenfield (design-first, starting from PRD) and brownfield (code-first, starting from reverse-engineering) projects. Pipeline guides **MUST** exist for greenfield, brownfield, and monolith scenarios.

**Implements**:
- `cpt-cypilot-algo-sdlc-kit-resolve-pipeline`

**Covers (PRD)**:
- `cpt-cypilot-fr-sdlc-pipeline`

**Covers (DESIGN)**:
- `cpt-cypilot-component-sdlc-plugin`
- `cpt-cypilot-principle-dry`

### Generated Output Integrity

- [x] `p1` - **ID**: `cpt-cypilot-dod-sdlc-kit-output-integrity`

All kit files (templates, rules, checklists, examples, constraints) **MUST** be present and structurally valid. Each artifact kind **MUST** have: `rules.md`, `template.md`, `checklist.md`, and `examples/example.md`. Kit-wide files **MUST** include `constraints.toml` and `conf.toml`. Codebase directory **MUST** contain `codebase/rules.md` and `codebase/checklist.md`.

**Implements**:
- `cpt-cypilot-algo-sdlc-kit-validate-completeness`

**Covers (PRD)**:
- `cpt-cypilot-fr-sdlc-plugin`

**Covers (DESIGN)**:
- `cpt-cypilot-component-sdlc-plugin`
- `cpt-cypilot-constraint-markdown-contract`

### Self-Check Command

- [x] `p1` - **ID**: `cpt-cypilot-dod-sdlc-kit-self-check`

The system **MUST** provide `cpt self-check` that validates all installed kits have complete file sets. Output **MUST** be JSON with PASS/FAIL status, per-kit details, and coverage metrics (kinds verified, files checked). Missing files **MUST** be reported with file paths and suggested fix commands.

**Implements**:
- `cpt-cypilot-flow-sdlc-kit-self-check`

**Covers (PRD)**:
- `cpt-cypilot-fr-sdlc-pipeline`

**Covers (DESIGN)**:
- `cpt-cypilot-component-sdlc-plugin`

## 6. Implementation Modules

| Module | Path | Responsibility |
|--------|------|----------------|
| SDLC Kit Files | `kits/sdlc/artifacts/*/` | Per-artifact files (rules, templates, checklists, examples) |
| SDLC Config | `kits/sdlc/conf.toml` | Kit metadata and configuration |
| PR Review Script | `kits/sdlc/scripts/pr.py` | PR review/status workflow entry point |
| Artifacts Meta | `skills/.../utils/artifacts_meta.py` | Registry parsing, autodetect expansion (shared with F-01) |

## 7. Acceptance Criteria

- [x] All 5 artifact kinds (PRD, DESIGN, ADR, DECOMPOSITION, FEATURE) have per-artifact directories in `kits/sdlc/artifacts/` with required files (rules.md, template.md, checklist.md, examples/example.md)
- [x] Codebase directory exists with `codebase/rules.md` and `codebase/checklist.md`
- [x] Kit includes `SKILL.md` and workflow files in `workflows/`
- [x] `cpt self-check` reports PASS for a correctly installed kit with complete outputs
- [x] `cpt self-check` reports FAIL with details when outputs are missing or stale
- [x] Pipeline guidance correctly identifies greenfield vs brownfield starting points
- [x] Each artifact kind is usable independently without requiring prior artifact kinds
- [x] Guides exist for greenfield (`GREENFIELD.md`), brownfield (`BROWNFIELD.md`), and monolith (`MONOLITH.md`) scenarios
- [x] `constraints.toml` defines all heading and ID constraints for SDLC artifact kinds
- [x] All commands output JSON to stdout and use exit codes 0 (PASS) / 2 (FAIL)
