# Decomposition: {Epic Name}

<!-- @cpt:blueprint name="DECOMPOSITION-EPIC" kind="template" -->

## Table of Contents

<!-- toc -->

<!-- /toc -->

## 1. Overview

This document decomposes the {Epic} DESIGN into Features. Each Feature is a discrete piece of functionality that can be implemented, tested, and delivered independently.

**Parent Documents:**
- Epic PRD: [PRD.md](./PRD.md)
- Epic DESIGN: [DESIGN.md](./DESIGN.md)
- SubApp DECOMPOSITION: [../DECOMPOSITION.md](../DECOMPOSITION.md)

## 2. Feature Entries

**Overall implementation status:**

- [ ] `p1` - **ID**: `cpt-{subapp}-{epic}-status-overall`

---

### 2.1 [{Feature Name 1}](features/{feature1}/) - HIGH

- [ ] `p1` - **ID**: `cpt-{subapp}-feature-{feature1}`

- **Purpose**: {Few sentences describing what this feature accomplishes and why it matters}

- **Depends On**: None

- **Scope**:
  - {in-scope item 1}
  - {in-scope item 2}

- **Out of scope**:
  - {out-of-scope item}

- **Requirements Covered**:
  - [ ] `p1` - `cpt-{subapp}-epic-{epic}-fr-{slug}` — {requirement summary}

- **Design Components**:
  - [ ] `p1` - `cpt-{subapp}-{epic}-component-{slug}` — {component from Epic DESIGN}

- **Screen/Widget**:
  - [ ] `p1` - `cpt-{subapp}-{epic}-screen-{slug}` — {screen component}
  - [ ] `p1` - `cpt-{subapp}-{epic}-widget-{slug}` — {widget component}

- **Use Cases**:
  - [ ] `p1` - `cpt-{subapp}-{epic}-usecase-{slug}` — {use case}

- **API Endpoints**:
  - `GET /api/v1/mobile/{subapp}/{resource}`
  - `POST /api/v1/mobile/{subapp}/{resource}`

- **Platform Implementation**:

| Platform | Module | Location |
|----------|--------|----------|
| KMP | `{Feature}ViewModel`, `{Feature}UseCase` | `constructor-sdk/feature/{subapp}/` |
| Android | `{Feature}Screen` | `android-app/feature/{subapp}/ui/` |
| iOS | `{Feature}View` | `ios-app/Features/{SubApp}/Views/` |

---

### 2.2 [{Feature Name 2}](features/{feature2}/) - MEDIUM

- [ ] `p2` - **ID**: `cpt-{subapp}-feature-{feature2}`

- **Purpose**: {Description}

- **Depends On**: `cpt-{subapp}-feature-{feature1}`

- **Scope**:
  - {scope item}

- **Out of scope**:
  - {out-of-scope}

- **Requirements Covered**:
  - [ ] `p2` - `cpt-{subapp}-epic-{epic}-fr-{slug}` — {requirement}

- **Design Components**:
  - [ ] `p2` - `cpt-{subapp}-{epic}-component-{slug}` — {component}

- **State Management**:
  - [ ] `p2` - `cpt-{subapp}-{epic}-state` — {state from DESIGN}

- **Platform Implementation**:

| Platform | Module | Location |
|----------|--------|----------|
| KMP | `{Module}` | `constructor-sdk/feature/{subapp}/` |
| Android | `{Component}` | `android-app/feature/{subapp}/` |
| iOS | `{Component}` | `ios-app/Features/{SubApp}/` |

---

### 2.3 [{Feature Name 3}](features/{feature3}/) - LOW

- [ ] `p3` - **ID**: `cpt-{subapp}-feature-{feature3}`

- **Purpose**: {Description}

- **Depends On**: `cpt-{subapp}-feature-{feature1}`, `cpt-{subapp}-feature-{feature2}`

- **Scope**:
  - {scope item}

- **Out of scope**:
  - {out-of-scope}

- **Requirements Covered**:
  - [ ] `p3` - `cpt-{subapp}-epic-{epic}-fr-{slug}` — {requirement}

- **Design Components**:
  - [ ] `p3` - `cpt-{subapp}-{epic}-component-{slug}` — {component}

---

## 3. Feature Dependencies

```text
cpt-{subapp}-feature-{feature1}
    │
    ├─→ cpt-{subapp}-feature-{feature2}
    │       │
    │       └─→ cpt-{subapp}-feature-{feature3}
    │
    └─→ cpt-{subapp}-feature-{feature4}
```

**Dependency Rationale**:

- `cpt-{subapp}-feature-{feature2}` requires `cpt-{subapp}-feature-{feature1}`: {explain why}
- `cpt-{subapp}-feature-{feature3}` requires both: {explain why}

## 4. Coverage Matrix

### 4.1 Requirements → Features

| Requirement ID | Feature | Priority | Status |
|----------------|---------|----------|--------|
| `cpt-{subapp}-epic-{epic}-fr-{slug1}` | `cpt-{subapp}-feature-{feature1}` | p1 | ☐ |
| `cpt-{subapp}-epic-{epic}-fr-{slug2}` | `cpt-{subapp}-feature-{feature2}` | p2 | ☐ |

### 4.2 Design Components → Features

| Component ID | Feature | Status |
|--------------|---------|--------|
| `cpt-{subapp}-{epic}-screen-{slug}` | `cpt-{subapp}-feature-{feature1}` | ☐ |
| `cpt-{subapp}-{epic}-widget-{slug}` | `cpt-{subapp}-feature-{feature2}` | ☐ |
| `cpt-{subapp}-{epic}-usecase-{slug}` | `cpt-{subapp}-feature-{feature1}` | ☐ |

### 4.3 Platform Implementation Matrix

| Feature | KMP | Android | iOS |
|---------|-----|---------|-----|
| `cpt-{subapp}-feature-{feature1}` | ☐ | ☐ | ☐ |
| `cpt-{subapp}-feature-{feature2}` | ☐ | ☐ | ☐ |
| `cpt-{subapp}-feature-{feature3}` | ☐ | ☐ | ☐ |

## 5. Implementation Order

| Phase | Features | Rationale |
|-------|----------|-----------|
| 1 | `cpt-{subapp}-feature-{feature1}` | Foundation, no dependencies |
| 2 | `cpt-{subapp}-feature-{feature2}` | Depends on phase 1 |
| 3 | `cpt-{subapp}-feature-{feature3}`, `cpt-{subapp}-feature-{feature4}` | Can be parallel after phase 2 |

## 6. Acceptance Criteria Summary

| Feature | Key Acceptance Criteria |
|---------|------------------------|
| `cpt-{subapp}-feature-{feature1}` | {1-2 key criteria} |
| `cpt-{subapp}-feature-{feature2}` | {1-2 key criteria} |

<!-- /@cpt:blueprint -->
