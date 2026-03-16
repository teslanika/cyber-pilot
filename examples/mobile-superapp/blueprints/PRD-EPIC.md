# PRD — {Epic Name}
<!-- @cpt:blueprint name="PRD-EPIC" kind="template" -->
<!-- @cpt:id cpt-{subapp}-epic-{epic}-prd -->

> **Level**: L2 (Epic)  
> **Parent SubApp**: [{SubApp Name} PRD](../../PRD.md) `cpt-{subapp}-prd`  
> **Parent Platform**: [Platform PRD](../../../../architecture/PRD.md) `cpt-superapp-prd`  
> **Version**: 1.0  
> **Status**: Draft

---

## 1. Overview

### 1.1 Purpose

<!-- Describe what this Epic (screen/capability/flow) does -->

This PRD defines requirements for the **{Epic Name}** epic within the {SubApp Name} SubApp.

**Epic Type:** Screen | Capability | Flow | Widget

### 1.2 Scope

**In Scope:**
- {screen/feature 1}
- {screen/feature 2}

**Out of Scope:**
- {explicitly excluded}

### 1.3 Traces To Parent Requirements

<!-- CRITICAL: Link to SubApp FRs that this Epic details -->

| SubApp Requirement | Relation | Description |
|-------------------|----------|-------------|
| `cpt-{subapp}-fr-{slug}` | details | {How this Epic details SubApp FR} |
| `cpt-{subapp}-fr-{slug-2}` | details | {Another SubApp FR this Epic covers} |

**Indirect Platform Trace:**
- `cpt-{subapp}-fr-{slug}` → `cpt-superapp-fr-{platform-slug}`

---

## 2. Actors & Context

### 2.1 Primary Actors

<!-- Reference Platform actors -->

| Actor ID | Role in this Epic |
|----------|------------------|
| `cpt-superapp-actor-student` | {Specific role in this epic} |

### 2.2 Entry Points

| Entry Point | Source | Trigger |
|-------------|--------|---------|
| Deep link | External | `constructor://student/{epic}` |
| Navigation | Tab bar | Tap on {icon} |
| Push notification | System | {notification type} |

---

## 3. Functional Requirements

### 3.1 Core Requirements

<!-- Each Epic FR must trace to SubApp FR OR be marked as Epic-specific -->

#### FR-01: {Requirement Name}
<!-- @cpt:id cpt-{subapp}-epic-{epic}-fr-{slug} -->

**Traces To:** `cpt-{subapp}-fr-{parent-slug}` (details)

| Attribute | Value |
|-----------|-------|
| Priority | P1 |
| Actor | `cpt-superapp-actor-{actor}` |
| Description | {Specific behavior in this screen/flow} |
| UI Element | {Widget/component involved} |
| Acceptance | {Specific acceptance criteria} |

---

#### FR-02: {Epic-Specific Requirement}
<!-- @cpt:id cpt-{subapp}-epic-{epic}-fr-{slug} -->
<!-- @cpt:tag epic-specific -->

**Traces To:** — (Epic-specific requirement)

| Attribute | Value |
|-----------|-------|
| Priority | P2 |
| Description | {Behavior specific to this Epic only} |
| Rationale | {Why this is needed at Epic level only} |

---

### 3.2 State Requirements

#### Screen States
<!-- @cpt:id cpt-{subapp}-epic-{epic}-state -->

| State | Condition | UI Behavior |
|-------|-----------|-------------|
| Loading | Initial load | Show skeleton |
| Content | Data loaded | Show main content |
| Empty | No data | Show empty state with CTA |
| Error | API failed | Show error with retry |
| Offline | No network | Show cached data with offline banner |

---

### 3.3 Error Handling

| Error Type | User Message | Recovery Action |
|------------|--------------|-----------------|
| Network timeout | "Check your connection" | Retry button |
| Invalid data | "Something went wrong" | Contact support link |
| Auth expired | "Session expired" | Redirect to login |

---

## 4. UI/UX Requirements

### 4.1 Screen Layout

```
┌────────────────────────────────┐
│ Navigation Bar                 │
├────────────────────────────────┤
│                                │
│ {Main Content Area}            │
│                                │
├────────────────────────────────┤
│ {Bottom Action Area}           │
└────────────────────────────────┘
```

### 4.2 Components

| Component | ID | Description |
|-----------|-----|-------------|
| {Widget Name} | `cpt-{subapp}-{epic}-widget-{slug}` | {Purpose} |
| {Widget Name 2} | `cpt-{subapp}-{epic}-widget-{slug-2}` | {Purpose} |

### 4.3 Interactions

| Interaction | Trigger | Result |
|-------------|---------|--------|
| Pull to refresh | Swipe down | Reload data |
| Tap item | Touch | Navigate to detail |
| Long press | Touch + hold | Show context menu |

---

## 5. Data Requirements

### 5.1 Required Data

| Data | Source | Caching |
|------|--------|---------|
| {Entity} | API: `GET /api/v1/{resource}` | 5 min TTL |
| {Entity 2} | Local DB | Persist |

### 5.2 API Contracts

| Endpoint | Method | Request | Response |
|----------|--------|---------|----------|
| `/api/v1/{resource}` | GET | `{ filters }` | `{ data[] }` |

---

## 6. Traceability Matrix

### 6.1 SubApp FR → Epic FR Coverage

<!-- This table shows which SubApp FRs are covered by this Epic -->

| SubApp FR | Epic FRs | Coverage |
|-----------|---------|----------|
| `cpt-{subapp}-fr-{slug-1}` | `cpt-{subapp}-epic-{epic}-fr-{a}` | Full |
| `cpt-{subapp}-fr-{slug-2}` | `cpt-{subapp}-epic-{epic}-fr-{b}`, `cpt-{subapp}-epic-{epic}-fr-{c}` | Full |

### 6.2 Epic FR → Feature Mapping

<!-- Track which Features will implement each Epic FR -->

| Epic FR | Target Feature | Status |
|---------|---------------|--------|
| `cpt-{subapp}-epic-{epic}-fr-{slug}` | `cpt-{subapp}-feature-{feature}` | Planned |

### 6.3 Full Traceability Chain

<!-- Show complete chain from Platform to Epic -->

```
Platform FR                    SubApp FR                      Epic FR
─────────────                  ─────────                      ───────
cpt-superapp-fr-{slug}    →    cpt-{subapp}-fr-{slug}    →    cpt-{subapp}-epic-{epic}-fr-{slug}
     ↓                              ↓                              ↓
DESIGN-PLATFORM             DESIGN-SUBAPP               DESIGN-EPIC
     ↓                              ↓                              ↓
                                                           FEATURE
```

---

## 7. Acceptance Criteria

- [ ] All SubApp FRs in scope are detailed
- [ ] All Epic FRs have feature specifications
- [ ] All states defined and designed
- [ ] All error scenarios handled
- [ ] Traceability chain verified

---

## Appendix: ID Reference

| ID Pattern | Example | Purpose |
|------------|---------|---------|
| `cpt-{subapp}-epic-{epic}-prd` | `cpt-student-epic-home-prd` | Epic PRD anchor |
| `cpt-{subapp}-epic-{epic}-fr-{slug}` | `cpt-student-epic-home-fr-streak` | Functional requirement |
| `cpt-{subapp}-epic-{epic}-state` | `cpt-student-epic-home-state` | State machine |
| `cpt-{subapp}-{epic}-widget-{slug}` | `cpt-student-home-widget-progress` | UI component |
