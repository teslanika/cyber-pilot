# PRD — {SubApp Name} SubApp
<!-- @cpt:blueprint name="PRD-SUBAPP" kind="template" -->
<!-- @cpt:id cpt-{subapp}-prd -->

> **Level**: L1 (SubApp)  
> **Parent**: [Platform PRD](../../architecture/PRD.md) `cpt-superapp-prd`  
> **Version**: 1.0  
> **Status**: Draft

---

## 1. Overview

### 1.1 Purpose

<!-- Describe what this SubApp does and why it exists -->

This PRD defines requirements for the **{SubApp Name}** SubApp within the Constructor Mobile SuperApp.

### 1.2 Scope

**In Scope:**
- {capability 1}
- {capability 2}

**Out of Scope:**
- {explicitly excluded capability}

### 1.3 Traces To Platform

<!-- CRITICAL: Link to parent Platform PRD and list which Platform FRs this SubApp refines -->

| Platform Requirement | Relation | Description |
|---------------------|----------|-------------|
| `cpt-superapp-fr-{slug}` | refines | {How this SubApp refines Platform FR} |
| `cpt-superapp-nfr-{slug}` | inherits | {Which Platform NFRs apply} |

---

## 2. Actors

### 2.1 Primary Actors

<!-- Reference Platform actors, don't redefine -->

| Actor ID | Role | SubApp-Specific Context |
|----------|------|------------------------|
| `cpt-superapp-actor-student` | Primary | {How student uses this SubApp} |
| `cpt-superapp-actor-instructor` | Secondary | {How instructor uses this SubApp} |

---

## 3. Functional Requirements

### 3.1 Core Capabilities

<!-- Each FR must trace to Platform FR OR be marked as SubApp-specific -->

#### FR-01: {Feature Name}
<!-- @cpt:id cpt-{subapp}-fr-{slug} -->

**Traces To:** `cpt-superapp-fr-{parent-slug}` (refines)

| Attribute | Value |
|-----------|-------|
| Priority | P1 |
| Actor | `cpt-superapp-actor-{actor}` |
| Description | {What the system must do} |
| Acceptance | {Measurable acceptance criteria} |

---

#### FR-02: {SubApp-Specific Feature}
<!-- @cpt:id cpt-{subapp}-fr-{slug} -->
<!-- @cpt:tag subapp-specific -->

**Traces To:** — (SubApp-specific requirement)

| Attribute | Value |
|-----------|-------|
| Priority | P2 |
| Actor | `cpt-superapp-actor-{actor}` |
| Description | {SubApp-specific capability not from Platform} |
| Rationale | {Why this is needed at SubApp level only} |

---

### 3.2 SubApp-Level NFRs

<!-- Only include NFRs that EXTEND or OVERRIDE Platform NFRs -->

#### NFR-01: {Quality Attribute}
<!-- @cpt:id cpt-{subapp}-nfr-{slug} -->

**Traces To:** `cpt-superapp-nfr-{parent-slug}` (extends)

| Attribute | Value |
|-----------|-------|
| Category | Performance / Security / Usability |
| Metric | {Measurable metric} |
| Target | {Specific target value} |
| Rationale | {Why SubApp needs stricter/different requirement} |

---

## 4. Use Cases

### UC-01: {Use Case Name}
<!-- @cpt:id cpt-{subapp}-usecase-{slug} -->

**Traces To:** `cpt-{subapp}-fr-{slug}`

| Attribute | Value |
|-----------|-------|
| Primary Actor | `cpt-superapp-actor-{actor}` |
| Precondition | {Starting state} |
| Main Flow | 1. {Step 1}<br/>2. {Step 2}<br/>3. {Step 3} |
| Postcondition | {End state} |
| Exceptions | {Error scenarios} |

---

## 5. Dependencies

### 5.1 Platform Dependencies

| Dependency | Type | Description |
|------------|------|-------------|
| Auth Kernel | Required | `cpt-superapp-component-auth-kernel` |
| Storage Kernel | Required | `cpt-superapp-component-storage-kernel` |

### 5.2 External Dependencies

| System | Integration Type | Description |
|--------|-----------------|-------------|
| {Backend Service} | API | {What data/operations} |

---

## 6. Traceability Matrix

### 6.1 Platform FR → SubApp FR Coverage

<!-- This table shows which Platform FRs are covered by this SubApp -->

| Platform FR | SubApp FRs | Coverage Status |
|-------------|-----------|-----------------|
| `cpt-superapp-fr-{slug-1}` | `cpt-{subapp}-fr-{a}`, `cpt-{subapp}-fr-{b}` | Full |
| `cpt-superapp-fr-{slug-2}` | `cpt-{subapp}-fr-{c}` | Partial |
| `cpt-superapp-fr-{slug-3}` | — | Not in scope |

### 6.2 SubApp FR → Epic Coverage

<!-- This table tracks where each SubApp FR is detailed -->

| SubApp FR | Target Epics | Status |
|-----------|--------------|--------|
| `cpt-{subapp}-fr-{slug}` | Home, Settings | Planned |

---

## 7. Acceptance Criteria

- [ ] All Platform FRs in scope are refined
- [ ] All SubApp FRs have epic-level detailing
- [ ] All use cases have corresponding features
- [ ] Traceability matrix complete

---

## Appendix: ID Reference

| ID Pattern | Example | Purpose |
|------------|---------|---------|
| `cpt-{subapp}-prd` | `cpt-student-prd` | SubApp PRD anchor |
| `cpt-{subapp}-fr-{slug}` | `cpt-student-fr-course-list` | Functional requirement |
| `cpt-{subapp}-nfr-{slug}` | `cpt-student-nfr-offline` | Non-functional requirement |
| `cpt-{subapp}-usecase-{slug}` | `cpt-student-usecase-browse` | Use case |
