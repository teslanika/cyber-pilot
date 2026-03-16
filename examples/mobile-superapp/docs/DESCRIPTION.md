# Mobile SuperApp Kit — Description

## What Is This

Mobile SuperApp Kit is a custom set of templates and rules for Cypilot, adapted for mobile application development. The kit implements a multi-level documentation hierarchy with full requirement traceability from business goals to code.

## Problem We Solve

When developing a mobile SuperApp, managing requirements becomes complex:

1. **Platform** (SuperApp) has shared requirements (authentication, push notifications, deep links)
2. **SubApps** (Student, Proctor, Groups) have their own specific requirements
3. **Screens and features** detail SubApp requirements into specific UI/UX specifications
4. **Code** must be linked to requirements for coverage verification

The standard Cypilot SDLC kit supports only one level (system → features). We need a cascading structure.

## What We Created

### 1. Four-Level PRD Hierarchy

```
L0: Platform PRD (Shared Kernel)
    ├── Authentication (SSO, Apple, E-Devlet)
    ├── Push Notification Infrastructure
    ├── Deep Link Routing
    └── NFRs (Performance, Security, Compliance)

L1: SubApp PRD (Student, Proctor, Groups)
    ├── Courses, Assignments, Calendar
    ├── Notifications UI
    └── Communication (Inbox, Announcements)

L2: Epic PRD (Screens, Capabilities, Flows)
    ├── Notification History Screen
    ├── Course Catalog Screen
    └── Assignment Flow

L3: Feature Spec (CDSL)
    ├── Notification Badge
    ├── Notification List
    └── Mark All as Read
```

### 2. Cascading Requirement Traceability

Each requirement at a lower level references its parent:

```
Platform FR: cpt-superapp-fr-inapp-notifications
    │
    │ refined-by (refined in SubApp context)
    ▼
SubApp FR: cpt-student-fr-notifications
    │
    │ detailed-by (detailed to specific screen)
    ▼
Epic FR: cpt-student-epic-notification-history-fr-badge
    │
    │ specified-by (specified in CDSL)
    ▼
Feature: cpt-student-feature-notification-badge
    │
    │ implemented-by (implemented in code)
    ▼
Code: @cpt-impl:cpt-student-feature-notification-badge
```

### 3. Documentation Templates

**PRD templates:**
- `PRD-SUBAPP.md` — for SubApp with "Traces To Platform" table
- `PRD-EPIC.md` — for screens with "Traces To SubApp" table

**DESIGN templates:**
- `DESIGN-PLATFORM.md` — platform architecture (KMP, Native vs WebView)
- `DESIGN-SUBAPP.md` — SubApp modules (KMP, Android, iOS)
- `DESIGN-EPIC.md` — screen components (MVI, Use Cases)

**Other templates:**
- `DECOMPOSITION-*.md` — decomposition at each level
- `FEATURE-MOBILE.md` — CDSL specification with platform sections
- `IMPL-KMP/ANDROID/IOS.md` — code references

### 4. Validation Rules

The kit includes automatic checks:

| Rule | Description |
|------|-------------|
| platform-fr-coverage | Every Platform FR must be refined in SubApp |
| subapp-fr-coverage | Every SubApp FR must be detailed in Epic |
| epic-fr-coverage | Every Epic FR must be specified in Feature |
| feature-impl-coverage | Every Feature must have @cpt-impl in code |

### 5. ID Naming Conventions

| Level | Pattern | Example |
|-------|---------|---------|
| Platform | `cpt-{platform}-fr-{slug}` | `cpt-superapp-fr-offline` |
| SubApp | `cpt-{subapp}-fr-{slug}` | `cpt-student-fr-notifications` |
| Epic | `cpt-{subapp}-epic-{epic}-fr-{slug}` | `cpt-student-epic-home-fr-badge` |
| Feature | `cpt-{subapp}-feature-{slug}` | `cpt-student-feature-daily-goal` |

## Benefits

1. **Transparency**: See which business requirements are covered and which are not
2. **Navigation**: Trace from code to business goal and back
3. **Control**: Validation warns about "orphaned" requirements
4. **Onboarding**: New developers understand project structure
5. **Review**: PM and architects see the full requirements picture

## Usage Example

### Task: Add notification history screen

1. **Check Platform PRD** — exists `cpt-superapp-fr-inapp-notifications`
2. **Create SubApp FR** in Student PRD:
   ```markdown
   <!-- @cpt:id cpt-student-fr-notifications -->
   **Traces To:** `cpt-superapp-fr-inapp-notifications` (refines)
   ```
3. **Create Epic PRD** for Notification History:
   ```markdown
   <!-- @cpt:id cpt-student-epic-notification-history-fr-badge -->
   **Traces To:** `cpt-student-fr-notifications` (details)
   ```
4. **Run validation**:
   ```bash
   cpt validate --check=subapp-fr-coverage
   ```

## Installation

```bash
cd mobile-superapp
./cypilot/kits/mobile-superapp/install.sh
```

The script creates a symlink to the Cypilot kits folder and (optionally) updates `artifacts.toml`.

## Rollback

```bash
./cypilot/kits/mobile-superapp/uninstall.sh
```

The standard SDLC kit remains untouched.

---

**Version:** 2.0  
**Date:** March 2026  
**Author:** Constructor Mobile Team
