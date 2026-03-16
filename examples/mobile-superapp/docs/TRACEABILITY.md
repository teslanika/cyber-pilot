# Mobile SuperApp — Requirement Traceability

## Overview

This document explains how requirement traceability works across all levels of the Mobile SuperApp documentation hierarchy.

## The Traceability Cascade

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         PLATFORM LEVEL (L0)                                  │
│                       architecture/PRD.md                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│  cpt-superapp-fr-offline-support                                            │
│  cpt-superapp-fr-multi-language                                             │
│  cpt-superapp-fr-push-notifications                                         │
│  cpt-superapp-nfr-performance                                               │
│  cpt-superapp-actor-student                                                 │
└─────────────────────────────────────────────────────────────────────────────┘
                          │
                          │ refined-by
                          ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                         SUBAPP LEVEL (L1)                                    │
│                    subapps/student/PRD.md                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│  cpt-student-fr-course-catalog ────────────► refines: cpt-superapp-fr-*     │
│  cpt-student-fr-offline-content ───────────► refines: cpt-superapp-fr-offline│
│  cpt-student-fr-progress-sync ─────────────► refines: cpt-superapp-fr-*     │
│  cpt-student-fr-local-ui [subapp-specific] ► no parent (local requirement)  │
└─────────────────────────────────────────────────────────────────────────────┘
                          │
                          │ detailed-by
                          ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                          EPIC LEVEL (L2)                                     │
│              subapps/student/screens/home/PRD.md                             │
├─────────────────────────────────────────────────────────────────────────────┤
│  cpt-student-epic-home-fr-daily-goal ──────► details: cpt-student-fr-progress│
│  cpt-student-epic-home-fr-streak ──────────► details: cpt-student-fr-progress│
│  cpt-student-epic-home-fr-recommendations ─► details: cpt-student-fr-catalog │
│  cpt-student-epic-home-fr-animation [epic] ► no parent (UX-specific)        │
└─────────────────────────────────────────────────────────────────────────────┘
                          │
                          │ specified-by
                          ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                        FEATURE LEVEL (L3)                                    │
│         subapps/student/screens/home/features/daily-goal/FEATURE.md          │
├─────────────────────────────────────────────────────────────────────────────┤
│  cpt-student-feature-daily-goal ───────────► implements:                     │
│      • cpt-student-epic-home-fr-daily-goal                                  │
│      • cpt-student-epic-home-fr-streak                                      │
│                                                                              │
│  cpt-student-dod-daily-goal-display ───────► implements: epic-fr-daily-goal │
│  cpt-student-dod-daily-goal-update ────────► implements: epic-fr-daily-goal │
└─────────────────────────────────────────────────────────────────────────────┘
                          │
                          │ implemented-by
                          ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                          CODE LEVEL                                          │
├─────────────────────────────────────────────────────────────────────────────┤
│  constructor-sdk/feature/home/DailyGoalUseCase.kt                           │
│      // @cpt-impl:cpt-student-feature-daily-goal                            │
│                                                                              │
│  android-app/feature/home/DailyGoalWidget.kt                                │
│      // @cpt-impl:cpt-student-dod-daily-goal-display                        │
│                                                                              │
│  ios-app/Features/Home/DailyGoalView.swift                                  │
│      // @cpt-impl:cpt-student-dod-daily-goal-display                        │
└─────────────────────────────────────────────────────────────────────────────┘
```

## ID Patterns

| Level | ID Pattern | Example |
|-------|------------|---------|
| Platform FR | `cpt-{platform}-fr-{slug}` | `cpt-superapp-fr-offline-support` |
| Platform NFR | `cpt-{platform}-nfr-{slug}` | `cpt-superapp-nfr-performance` |
| Platform Actor | `cpt-{platform}-actor-{slug}` | `cpt-superapp-actor-student` |
| SubApp FR | `cpt-{subapp}-fr-{slug}` | `cpt-student-fr-course-catalog` |
| Epic FR | `cpt-{subapp}-epic-{epic}-fr-{slug}` | `cpt-student-epic-home-fr-streak` |
| Feature | `cpt-{subapp}-feature-{slug}` | `cpt-student-feature-daily-goal` |
| DOD | `cpt-{subapp}-dod-{feature}-{slug}` | `cpt-student-dod-daily-goal-display` |

## Traceability Tables in PRDs

### SubApp PRD — "Traces To Platform" Table

Every SubApp PRD **must** include a traceability table:

```markdown
## 3. Traces To Platform

| Platform Requirement | Relation | SubApp Coverage |
|---------------------|----------|-----------------|
| `cpt-superapp-fr-offline-support` | refines | `cpt-student-fr-offline-content` |
| `cpt-superapp-fr-multi-language` | inherits | Uses Platform language settings |
| `cpt-superapp-nfr-performance` | extends | Stricter: <1s screen load |
```

### Epic PRD — "Traces To SubApp" Table

Every Epic PRD **must** include a traceability table:

```markdown
## 3. Traces To SubApp

| SubApp Requirement | Relation | Epic FRs |
|-------------------|----------|----------|
| `cpt-student-fr-progress-sync` | details | `cpt-student-epic-home-fr-daily-goal`, `cpt-student-epic-home-fr-streak` |
| `cpt-student-fr-course-catalog` | details | `cpt-student-epic-home-fr-recommendations` |
```

### Feature — "Implements" Table

Every Feature **must** include references to Epic FRs:

```markdown
## 1. Feature Context

### 1.3 Implements

| Epic Requirement | Coverage |
|-----------------|----------|
| `cpt-student-epic-home-fr-daily-goal` | Full |
| `cpt-student-epic-home-fr-streak` | Partial (display only) |
```

## Validation Rules

### Error-Level Rules

| Rule ID | Description | Severity |
|---------|-------------|----------|
| `platform-fr-coverage` | Every Platform FR must be refined by SubApp FR | Error |
| `subapp-fr-coverage` | Every SubApp FR must be detailed by Epic FR | Error |
| `epic-fr-coverage` | Every Epic FR must be specified in Feature | Error |

### Warning-Level Rules

| Rule ID | Description | Severity |
|---------|-------------|----------|
| `child-fr-traces-parent` | Child FR should reference parent in Traces To | Warning |
| `feature-impl-coverage` | Feature should have @cpt-impl markers | Warning |

### Info-Level Rules

| Rule ID | Description | Severity |
|---------|-------------|----------|
| `no-orphan-subapp-fr` | SubApp FR without Platform parent should be tagged | Info |
| `no-orphan-epic-fr` | Epic FR without SubApp parent should be tagged | Info |

## Orphan Requirements

Sometimes requirements exist only at one level and don't trace to a parent. These are valid but must be documented:

### SubApp-Specific Requirements

```markdown
#### FR-07: Local UI Customization
<!-- @cpt:id cpt-student-fr-local-ui -->
<!-- @cpt:tag subapp-specific -->

**Traces To:** — (SubApp-specific requirement)

**Rationale:** This requirement is specific to the Student SubApp UX 
and doesn't derive from any Platform FR.
```

### Epic-Specific Requirements

```markdown
#### FR-04: Animation Effects
<!-- @cpt:id cpt-student-epic-home-fr-animation -->
<!-- @cpt:tag epic-specific -->

**Traces To:** — (Epic-specific UX requirement)

**Rationale:** Home screen animations are specific to this epic
and don't trace to SubApp requirements.
```

## Coverage Matrix Example

A complete traceability matrix shows coverage from Platform to Code:

```
Platform FR              SubApp FRs                 Epic FRs                   Features
──────────────           ──────────                 ────────                   ────────
cpt-superapp-fr-offline
    │
    ├─► cpt-student-fr-offline-content
    │       │
    │       ├─► cpt-student-epic-home-fr-cached ─────► cpt-student-feature-cache
    │       │
    │       └─► cpt-student-epic-course-fr-download ─► cpt-student-feature-download
    │
    └─► cpt-proctor-fr-offline-capture
            │
            └─► cpt-proctor-epic-exam-fr-local ──────► cpt-proctor-feature-local-exam
```

## Validation Commands

```bash
# Full traceability validation
cpt validate --kit=mobile-superapp --check=traceability

# Check specific cascade level
cpt validate --check=platform-fr-coverage
cpt validate --check=subapp-fr-coverage
cpt validate --check=epic-fr-coverage

# Generate coverage report
cpt report --coverage --format=markdown > coverage-report.md

# Find orphan requirements
cpt validate --check=no-orphan-subapp-fr
cpt validate --check=no-orphan-epic-fr
```

## Configuration Location

All traceability rules are defined in:

```
cypilot/kits/mobile-superapp/constraints.toml
```

Key sections:
- `[identifiers.*]` — ID patterns and where they're defined/referenced
- `[traceability]` — Document-level trace relationships
- `[traceability.requirements]` — FR cascade rules
- `[validation.rules]` — Validation checks
