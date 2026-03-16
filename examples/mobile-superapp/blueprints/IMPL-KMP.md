# Implementation Reference — KMP Shared Logic

<!-- @cpt:blueprint name="IMPL-KMP" kind="template" -->

## Overview

This document links the KMP (Kotlin Multiplatform) implementation to its product documentation.

**Module**: `constructor-sdk/feature/{module}/`

## References

| Document | Path | ID |
|----------|------|-----|
| Feature | [subapps/{subapp}/.../features/{feature}/FEATURE.md](../../subapps/{subapp}/.../features/{feature}/FEATURE.md) | `cpt-{subapp}-feature-{slug}` |
| Epic DESIGN | [subapps/{subapp}/.../DESIGN.md](../../subapps/{subapp}/.../DESIGN.md) | `cpt-{subapp}-epic-{epic}` |
| SubApp DESIGN | [subapps/{subapp}/DESIGN.md](../../subapps/{subapp}/DESIGN.md) | `cpt-{subapp}-design` |

## Scope

This KMP module implements:
- Section 3.1 (KMP Shared Logic) from FEATURE.md
- ViewModel, UseCase, Repository components from DESIGN.md

## Implementation Notes

{Platform-specific decisions, deviations from design, implementation constraints}

## Traceability Table

| Design Component ID | Code File | Implementation ID |
|---------------------|-----------|-------------------|
| `cpt-{subapp}-{epic}-usecase-{slug}` | `src/commonMain/kotlin/.../usecase/{UseCase}.kt` | `@cpt-impl cpt-kmp-{module}-usecase-{slug}` |
| `cpt-{subapp}-{epic}-state` | `src/commonMain/kotlin/.../presentation/{State}.kt` | `@cpt-impl cpt-kmp-{module}-state-{slug}` |
| `cpt-{subapp}-component-kmp-presentation` | `src/commonMain/kotlin/.../presentation/{ViewModel}.kt` | `@cpt-impl cpt-kmp-{module}-vm-{slug}` |
| `cpt-{subapp}-repo-{slug}` | `src/commonMain/kotlin/.../data/{Repository}Impl.kt` | `@cpt-impl cpt-kmp-{module}-repo-{slug}` |
| `cpt-{subapp}-entity-{slug}` | `src/commonMain/kotlin/.../domain/model/{Entity}.kt` | `@cpt-impl cpt-kmp-{module}-entity-{slug}` |

## Directory Structure

```
constructor-sdk/feature/{module}/
├── IMPL.md                           ← This file
├── src/
│   └── commonMain/
│       └── kotlin/
│           └── com/constructor/sdk/feature/{module}/
│               ├── domain/
│               │   ├── model/        # Domain entities
│               │   └── usecase/      # Use cases
│               ├── data/
│               │   ├── repository/   # Repository implementations
│               │   ├── remote/       # API clients, DTOs
│               │   └── local/        # Local data sources
│               └── presentation/
│                   ├── {Feature}ViewModel.kt
│                   ├── {Feature}State.kt
│                   ├── {Feature}Intent.kt
│                   └── {Feature}Effect.kt
└── build.gradle.kts
```

## Code Markers

All implementations include `@cpt-impl` markers for traceability:

```kotlin
// @cpt-impl cpt-kmp-{module}-usecase-{slug}
class {UseCase}UseCase(
    private val repository: {Repository}
) : UseCase<{Input}, {Output}> {
    override suspend fun invoke(input: {Input}): Result<{Output}> {
        // Implementation
    }
}
```

## Validation

Run `cypilot validate --artifact constructor-sdk/feature/{module}/` to verify:
- All design components have `@cpt-impl` markers in code
- All code markers reference valid design IDs
- Coverage meets minimum threshold

<!-- /@cpt:blueprint -->
