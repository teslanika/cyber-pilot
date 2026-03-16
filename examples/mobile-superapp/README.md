# Mobile SuperApp Kit

Custom Cypilot kit for mobile application development with **multi-level requirement traceability**.

---

## Problem We Solve

Standard SDLC kit supports only one level: **System → Features**.

Mobile SuperApp needs **4 levels**:
- **Platform** — shared kernel (auth, push, deep links)
- **SubApp** — domain applications (Student, Proctor, Groups)
- **Epic** — screens, capabilities, user flows
- **Feature** — CDSL specifications with platform-specific implementation

This kit provides cascading requirement traceability from business goals to code.

---

## Documentation Hierarchy

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         PLATFORM LEVEL (L0)                                  │
│                       architecture/PRD.md                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│  • Authentication (SSO, Apple, E-Devlet, Biometric)                         │
│  • Push Notification Infrastructure                                          │
│  • Deep Link Routing                                                          │
│  • SubApp Container & Lifecycle                                               │
│  • NFRs (Performance, Security, Compliance)                                   │
│  • KMP SDK, API Contracts                                                     │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                         SUBAPP LEVEL (L1)                                    │
│                    subapps/{subapp}/PRD.md                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│  • Domain-specific requirements                                               │
│  • Course Management, Assignments, Calendar (Student)                         │
│  • Exam Proctoring, Face Recognition (Proctor)                                │
│  • Video Calls, Screen Sharing (Groups)                                       │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                          EPIC LEVEL (L2)                                     │
│              subapps/{subapp}/capabilities/{epic}/PRD.md                     │
├─────────────────────────────────────────────────────────────────────────────┤
│  • Screen-level requirements                                                  │
│  • UI/UX specifications                                                       │
│  • User flows and states                                                      │
│  • Error handling                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                        FEATURE LEVEL (L3)                                    │
│         subapps/{subapp}/capabilities/{epic}/features/{feature}/FEATURE.md   │
├─────────────────────────────────────────────────────────────────────────────┤
│  • CDSL behavioral specifications                                             │
│  • Platform-specific implementation (KMP, Android, iOS)                       │
│  • Definitions of Done                                                        │
│  • Acceptance Criteria                                                        │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Requirement Traceability Flow

Every requirement at a lower level **must trace** to its parent:

```
Platform FR                     SubApp FR                      Epic FR                        Feature
───────────────                 ─────────                      ───────                        ───────
cpt-superapp-fr-inapp-notifications
        │
        │ refined-by
        ▼
                                cpt-student-fr-notifications
                                        │
                                        │ detailed-by
                                        ▼
                                                               cpt-student-epic-notification-history-fr-badge
                                                               cpt-student-epic-notification-history-fr-list
                                                               cpt-student-epic-notification-history-fr-mark-read
                                                                       │
                                                                       │ specified-by
                                                                       ▼
                                                                                              cpt-student-feature-notification-badge
                                                                                              cpt-student-feature-notification-list
                                                                                                      │
                                                                                                      │ implemented-by
                                                                                                      ▼
                                                                                              @cpt-impl:cpt-student-feature-notification-badge
                                                                                              (in KMP, Android, iOS code)
```

---

## Templates (15 total)

### PRD Templates

| Template | Level | Description |
|----------|-------|-------------|
| **SDLC PRD** | L0 | Platform requirements (uses standard SDLC kit template) |
| **PRD-SUBAPP** | L1 | SubApp requirements with "Traces To Platform" table |
| **PRD-EPIC** | L2 | Epic requirements with "Traces To SubApp" table |

### DESIGN Templates

| Template | Level | Description |
|----------|-------|-------------|
| **DESIGN-PLATFORM** | L0 | Platform architecture (hybrid approach, KMP scope, shared kernel) |
| **DESIGN-SUBAPP** | L1 | SubApp module structure (KMP, Android, iOS modules) |
| **DESIGN-EPIC** | L2 | Screen components, state management (MVI), data flow |

### DECOMPOSITION Templates

| Template | Level | Description |
|----------|-------|-------------|
| **DECOMPOSITION-PLATFORM** | L0 | Platform → SubApps breakdown |
| **DECOMPOSITION-SUBAPP** | L1 | SubApp → Epics breakdown |
| **DECOMPOSITION-EPIC** | L2 | Epic → Features breakdown |

### Implementation Templates

| Template | Description |
|----------|-------------|
| **FEATURE-MOBILE** | CDSL specification with KMP/Android/iOS sections |
| **IMPL-KMP** | Kotlin Multiplatform implementation reference |
| **IMPL-ANDROID** | Android native implementation reference |
| **IMPL-IOS** | iOS native implementation reference |

---

## ID Naming Conventions

| Level | Pattern | Example |
|-------|---------|---------|
| Platform FR | `cpt-{platform}-fr-{slug}` | `cpt-superapp-fr-offline-support` |
| Platform NFR | `cpt-{platform}-nfr-{slug}` | `cpt-superapp-nfr-performance` |
| Platform Actor | `cpt-{platform}-actor-{slug}` | `cpt-superapp-actor-student` |
| SubApp FR | `cpt-{subapp}-fr-{slug}` | `cpt-student-fr-notifications` |
| Epic FR | `cpt-{subapp}-epic-{epic}-fr-{slug}` | `cpt-student-epic-home-fr-badge` |
| Feature | `cpt-{subapp}-feature-{slug}` | `cpt-student-feature-daily-goal` |
| DOD | `cpt-{subapp}-dod-{feature}-{slug}` | `cpt-student-dod-daily-goal-display` |
| Code Marker | `@cpt-impl:{feature-id}` | `@cpt-impl:cpt-student-feature-daily-goal` |

---

## Validation Rules

The kit includes automatic validation:

### Coverage Checks (Error Level)

| Rule | Description |
|------|-------------|
| `platform-fr-coverage` | Every Platform FR must be refined by at least one SubApp FR |
| `subapp-fr-coverage` | Every SubApp FR must be detailed by at least one Epic FR |
| `epic-fr-coverage` | Every Epic FR must be specified in at least one Feature |

### Implementation Checks (Warning Level)

| Rule | Description |
|------|-------------|
| `feature-impl-coverage` | Every Feature should have `@cpt-impl` markers in code |
| `child-fr-traces-parent` | Child FR should reference parent in "Traces To" table |

### Orphan Detection (Info Level)

| Rule | Description |
|------|-------------|
| `no-orphan-subapp-fr` | SubApp FR without Platform parent requires `@cpt:tag subapp-specific` |
| `no-orphan-epic-fr` | Epic FR without SubApp parent requires `@cpt:tag epic-specific` |

---

## Directory Structure

```
mobile-superapp/
├── README.md              # This file
├── SKILL.md               # Kit capabilities for Cypilot
├── AGENTS.md              # Agent navigation rules
├── INSTALL.md             # Installation guide
├── install.sh             # Installation script
├── uninstall.sh           # Uninstall script
├── constraints.toml       # Traceability & validation rules (492 lines)
├── blueprints/
│   ├── PRD-SUBAPP.md
│   ├── PRD-EPIC.md
│   ├── DESIGN-PLATFORM.md
│   ├── DESIGN-SUBAPP.md
│   ├── DESIGN-EPIC.md
│   ├── DECOMPOSITION-PLATFORM.md
│   ├── DECOMPOSITION-SUBAPP.md
│   ├── DECOMPOSITION-EPIC.md
│   ├── FEATURE-MOBILE.md
│   ├── IMPL-KMP.md
│   ├── IMPL-ANDROID.md
│   └── IMPL-IOS.md
└── docs/
    ├── TRACEABILITY.md    # Detailed traceability guide
    ├── DESCRIPTION.md     # Full description (Russian)
    └── SUMMARY.txt        # Plain text summary
```

---

## Installation

### Option 1: Copy to Your Project

```bash
# Copy kit to your project
cp -r examples/mobile-superapp your-project/cypilot/kits/mobile-superapp

# Update artifacts.toml
# Change: kit = "cypilot-sdlc" to kit = "mobile-superapp"
```

### Option 2: Use Install Script

```bash
cd your-project
./cypilot/kits/mobile-superapp/install.sh
```

The script will:
1. Create symlink or copy kit to cypilot kits folder
2. Optionally update `artifacts.toml` to enable the kit

---

## Use Cases

This kit is designed for:

- **SuperApp Architecture** — multiple apps in one container with shared kernel
- **Cross-Platform Development** — KMP shared logic + native UI (SwiftUI, Jetpack Compose)
- **Multi-Level Requirements** — Platform → SubApp → Epic → Feature hierarchy
- **End-to-End Traceability** — from business requirements to code implementation

### Example: Notification History Feature

```
Platform: cpt-superapp-fr-inapp-notifications (P1)
    │
    └─► SubApp: cpt-student-fr-notifications
            │
            └─► Epic: Notification History Screen
                    ├── cpt-student-epic-notification-history-fr-badge
                    ├── cpt-student-epic-notification-history-fr-list
                    ├── cpt-student-epic-notification-history-fr-mark-read
                    ├── cpt-student-epic-notification-history-fr-expand
                    └── cpt-student-epic-notification-history-fr-mark-all
```

---

## Documentation

- **[Traceability Guide](docs/TRACEABILITY.md)** — How requirement traceability works
- **[Detailed Description](docs/DESCRIPTION.md)** — Full kit description (Russian)
- **[Summary](docs/SUMMARY.txt)** — Plain text overview

---

## Configuration Files

### constraints.toml

Defines:
- ID patterns for each level
- Cross-reference rules between artifacts
- Validation rules for coverage checks
- Document-level traceability

### SKILL.md

Describes kit capabilities for Cypilot agent:
- Available artifact types
- Commands and workflows
- ID naming conventions

### AGENTS.md

Navigation rules for AI agent:
- Template selection by level
- Level detection by file path
- Traceability requirements

---

**Version**: 2.0  
**License**: Apache-2.0  
**Extends**: SDLC Kit
