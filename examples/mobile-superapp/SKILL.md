---
name: mobile-superapp
description: "Mobile SuperApp documentation kit with multi-level hierarchy: PRD → DESIGN → DECOMPOSITION → FEATURE → IMPL for Platform, SubApp, and Epic levels"
---

# Cypilot Skill — Kit `mobile-superapp`

Generated from kit `mobile-superapp` blueprints.

## Overview

This kit provides specialized templates for mobile SuperApp development with:
- **Multi-level PRD hierarchy** (Platform → SubApp → Epic)
- **Level-specific DESIGN templates** (Platform, SubApp, Epic)
- **Cascading DECOMPOSITION** (Platform → SubApps, SubApp → Epics, Epic → Features)
- **Mobile-specific FEATURE template** with KMP/Android/iOS sections
- **Platform-specific IMPL templates** (KMP, Android, iOS)

## Artifact Types

### PRD (reuse SDLC kit)
Standard PRD template from SDLC kit. Used at all levels (Platform, SubApp, Epic).

### DESIGN-PLATFORM
Platform-level architecture design for the entire SuperApp.

**Contains:**
- Platform architecture overview
- Cross-platform strategy (Native vs WebView)
- KMP SDK scope
- SubApp container model
- Shared kernel components
- External integrations

### DESIGN-SUBAPP
SubApp-level architecture design.

**Contains:**
- SubApp module structure (KMP, Android, iOS)
- Navigation architecture
- State management (MVI)
- Domain model
- API layer
- Kernel integration

### DESIGN-EPIC
Epic-level (screen/flow/capability) technical design.

**Contains:**
- Component architecture
- Screen/widget components
- State management
- Data flow (UseCase, Repository)
- Platform-specific considerations
- Error handling

### DECOMPOSITION-PLATFORM
Decomposes Platform DESIGN into SubApps.

### DECOMPOSITION-SUBAPP
Decomposes SubApp DESIGN into Epics (screens, capabilities, flows).

### DECOMPOSITION-EPIC
Decomposes Epic DESIGN into Features.

### FEATURE-MOBILE
Mobile-specific feature design with CDSL flows.

**Contains:**
- Actor flows (CDSL)
- Platform implementation sections (KMP, Android, iOS, WebView)
- State machines (CDSL)
- Definitions of Done
- Platform-specific acceptance criteria

### IMPL-KMP / IMPL-ANDROID / IMPL-IOS
Implementation reference documents linking code to product docs.

## Commands

### Validation
```bash
cypilot validate --artifact <path>
```

### ID Operations
```bash
cypilot list-ids --kind feature
cypilot where-defined --id <id>
cypilot where-used --id <id>
```

## Workflows

### Generate Platform Architecture
1. Create/update `architecture/PRD.md`
2. Create `architecture/DESIGN.md` using DESIGN-PLATFORM template
3. Create `architecture/DECOMPOSITION.md` listing SubApps
4. Create `architecture/adr/` for platform decisions

### Generate SubApp
1. Create `subapps/{subapp}/PRD.md`
2. Create `subapps/{subapp}/DESIGN.md` using DESIGN-SUBAPP template
3. Create `subapps/{subapp}/DECOMPOSITION.md` listing Epics
4. Create epics in `screens/`, `capabilities/`, `flows/`

### Generate Epic
1. Create `subapps/{subapp}/{category}/{epic}/PRD.md`
2. Create `DESIGN.md` using DESIGN-EPIC template
3. Create `DECOMPOSITION.md` listing Features
4. Create features in `features/`

### Generate Feature
1. Create `features/{feature}/FEATURE.md` using FEATURE-MOBILE template
2. Create IMPL.md files in code folders:
   - `constructor-sdk/feature/{module}/IMPL.md`
   - `android-app/feature/{module}/IMPL.md`
   - `ios-app/Features/{Module}/IMPL.md`

## ID Naming Conventions

| Level | Pattern | Example |
|-------|---------|---------|
| Platform FR | `cpt-{platform}-fr-{slug}` | `cpt-superapp-fr-offline` |
| Platform Component | `cpt-{platform}-component-{slug}` | `cpt-superapp-component-auth` |
| SubApp Epic | `cpt-{subapp}-epic-{slug}` | `cpt-student-epic-home` |
| Feature | `cpt-{subapp}-feature-{slug}` | `cpt-student-feature-daily-goal` |
| Flow | `cpt-{subapp}-flow-{feature}-{slug}` | `cpt-student-flow-daily-goal-main` |
| KMP Impl | `cpt-kmp-{module}-{type}-{slug}` | `cpt-kmp-home-usecase-load` |
| Android Impl | `cpt-android-{module}-{type}-{slug}` | `cpt-android-home-screen-main` |
| iOS Impl | `cpt-ios-{module}-{type}-{slug}` | `cpt-ios-home-view-main` |

## Traceability Chain

```
Platform PRD
    ↓ refined-by
Platform DESIGN + ADR
    ↓ decomposed-by
Platform DECOMPOSITION (SubApps)
    ↓ detailed-by
SubApp PRD
    ↓ designed-by
SubApp DESIGN + ADR
    ↓ decomposed-by
SubApp DECOMPOSITION (Epics)
    ↓ detailed-by
Epic PRD
    ↓ designed-by
Epic DESIGN + ADR
    ↓ decomposed-by
Epic DECOMPOSITION (Features)
    ↓ specified-by
FEATURE (CDSL)
    ↓ implemented-by
IMPL-KMP + IMPL-ANDROID + IMPL-IOS
    ↓ traces-to
Code (@cpt-impl markers)
```
