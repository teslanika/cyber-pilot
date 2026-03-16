# Decomposition: {SubApp Name} SubApp

<!-- @cpt:blueprint name="DECOMPOSITION-SUBAPP" kind="template" -->

## Table of Contents

<!-- toc -->

<!-- /toc -->

## 1. Overview

This document decomposes the {SubApp} SubApp DESIGN into Epics. Each Epic represents a screen, capability, or user flow that can be developed and tested independently.

**Parent Documents:**
- SubApp PRD: [PRD.md](./PRD.md)
- SubApp DESIGN: [DESIGN.md](./DESIGN.md)
- Platform DECOMPOSITION: [../DECOMPOSITION.md](../DECOMPOSITION.md)

## 2. Epic Entries

**Overall implementation status:**

- [ ] `p1` - **ID**: `cpt-{subapp}-status-overall`

---

### 2.1 Screens

#### [{Screen Name 1}](screens/{screen1}/) - HIGH

- [ ] `p1` - **ID**: `cpt-{subapp}-epic-{screen1}`

- **Category**: Screen

- **Purpose**: {Few sentences describing what this screen provides and why it matters}

- **Actors**: `cpt-{platform}-actor-{slug}`

- **Depends On**: None (entry point) / `cpt-{subapp}-epic-{slug}` (if dependent)

- **Scope**:
  - {widget/feature 1}
  - {widget/feature 2}

- **Out of scope**:
  - {out-of-scope item}

- **Requirements Covered**:
  - [ ] `p1` - `cpt-{subapp}-fr-{slug}` — {requirement summary}

- **Design Components**:
  - [ ] `p1` - `cpt-{subapp}-component-{slug}` — {component from SubApp DESIGN}

- **KMP Modules**:
  - `cpt-{subapp}-component-kmp-{slug}`

- **Target Release**: Q{X} 202{Y}

---

#### [{Screen Name 2}](screens/{screen2}/) - MEDIUM

- [ ] `p2` - **ID**: `cpt-{subapp}-epic-{screen2}`

- **Category**: Screen

- **Purpose**: {Description}

- **Actors**: `cpt-{platform}-actor-{slug}`

- **Depends On**: `cpt-{subapp}-epic-{screen1}`

- **Scope**:
  - {scope item}

- **Out of scope**:
  - {out-of-scope item}

- **Requirements Covered**:
  - [ ] `p2` - `cpt-{subapp}-fr-{slug}` — {requirement summary}

- **Design Components**:
  - [ ] `p2` - `cpt-{subapp}-component-{slug}` — {component}

---

### 2.2 Capabilities

#### [{Capability Name}](capabilities/{capability}/) - HIGH

- [ ] `p1` - **ID**: `cpt-{subapp}-epic-{capability}`

- **Category**: Capability (cross-cutting)

- **Purpose**: {Few sentences describing this cross-cutting capability}

- **Actors**: `cpt-{platform}-actor-{slug}`

- **Depends On**: Kernel services

- **Scope**:
  - {capability scope 1}
  - {capability scope 2}

- **Out of scope**:
  - {out-of-scope item}

- **Requirements Covered**:
  - [ ] `p1` - `cpt-{subapp}-fr-{slug}` — {requirement}
  - [ ] `p1` - `cpt-{subapp}-nfr-{slug}` — {NFR if applicable}

- **Design Components**:
  - [ ] `p1` - `cpt-{subapp}-component-{slug}` — {component}

- **Kernel Integration**:
  - `cpt-{platform}-component-{kernel-slug}` — {how it uses kernel}

---

### 2.3 Flows

#### [{Flow Name}](flows/{flow}/) - MEDIUM

- [ ] `p2` - **ID**: `cpt-{subapp}-epic-{flow}`

- **Category**: Flow (multi-screen journey)

- **Purpose**: {Few sentences describing this user flow}

- **Actors**: `cpt-{platform}-actor-{slug}`

- **Depends On**: 
  - `cpt-{subapp}-epic-{screen1}` — starting point
  - `cpt-{subapp}-epic-{screen2}` — intermediate step

- **Screens Involved**:
  - {Screen 1} → {Screen 2} → {Screen 3}

- **Scope**:
  - {flow scope}

- **Out of scope**:
  - {out-of-scope}

- **Requirements Covered**:
  - [ ] `p2` - `cpt-{subapp}-fr-{slug}` — {requirement}

- **Design Sequences**:
  - [ ] `p2` - `cpt-{subapp}-seq-{slug}` — {sequence from DESIGN}

---

## 3. Epic Dependencies

```text
cpt-{subapp}-epic-{foundation}
    │
    ├─→ cpt-{subapp}-epic-{dependent1}
    │       │
    │       └─→ cpt-{subapp}-epic-{sub-dependent}
    │
    └─→ cpt-{subapp}-epic-{dependent2}

cpt-{subapp}-epic-{capability} (cross-cutting, used by multiple screens)
```

**Dependency Rationale**:

- `cpt-{subapp}-epic-{dependent1}` requires `cpt-{subapp}-epic-{foundation}`: {explain why}
- `cpt-{subapp}-epic-{capability}` is used across screens: {list screens}

## 4. Coverage Matrix

### 4.1 Requirements Coverage

| Requirement ID | Epic | Status |
|----------------|------|--------|
| `cpt-{subapp}-fr-{slug1}` | `cpt-{subapp}-epic-{epic1}` | ☐ |
| `cpt-{subapp}-fr-{slug2}` | `cpt-{subapp}-epic-{epic2}` | ☐ |

### 4.2 Design Component Coverage

| Component ID | Epic | Status |
|--------------|------|--------|
| `cpt-{subapp}-component-{slug1}` | `cpt-{subapp}-epic-{epic1}` | ☐ |
| `cpt-{subapp}-component-{slug2}` | `cpt-{subapp}-epic-{epic2}` | ☐ |

## 5. Implementation Order

| Phase | Epics | Rationale |
|-------|-------|-----------|
| 1 | `cpt-{subapp}-epic-{foundation}` | Foundation, no dependencies |
| 2 | `cpt-{subapp}-epic-{capability}` | Cross-cutting, enables other epics |
| 3 | `cpt-{subapp}-epic-{dependent1}`, `cpt-{subapp}-epic-{dependent2}` | Can be parallel |
| 4 | `cpt-{subapp}-epic-{flow}` | Requires screens to be ready |

<!-- /@cpt:blueprint -->
