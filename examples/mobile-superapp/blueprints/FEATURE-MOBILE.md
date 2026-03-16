# Feature: {Feature Name}

<!-- @cpt:blueprint name="FEATURE-MOBILE" kind="template" -->

- [ ] `p1` - **ID**: `cpt-{subapp}-featstatus-{feature-slug}`

## Table of Contents

<!-- toc -->

<!-- /toc -->

## 1. Feature Context

- [ ] `p1` - `cpt-{subapp}-feature-{slug}`

### 1.1 Overview

{Brief overview of what this feature does — 1-2 sentences.}

### 1.2 Purpose

{Why this feature exists, what Epic PRD requirements or DESIGN element it addresses.}

### 1.3 Actors

| Actor | Role in Feature |
|-------|-----------------|
| `cpt-{platform}-actor-{slug}` | {What this actor does in this feature} |

### 1.4 References

- **Epic PRD**: [../PRD.md](../PRD.md)
- **Epic DESIGN**: [../DESIGN.md](../DESIGN.md)
- **DECOMPOSITION**: [../DECOMPOSITION.md](../DECOMPOSITION.md)
- **Dependencies**: {List feature dependencies or "None"}

## 2. Actor Flows (CDSL)

User-facing interactions that start with an actor (human or external system) and describe the end-to-end flow of a use case.

### 2.1 {Primary Flow Name}

- [ ] `p1` - **ID**: `cpt-{subapp}-flow-{feature-slug}-{slug}`

**Actor**: `cpt-{platform}-actor-{slug}`

**Success Scenarios**:
- {Scenario 1: Happy path}

**Error Scenarios**:
- {Error scenario 1}

**Steps**:
1. [ ] - `p1` - Actor opens {screen/widget} - `inst-{step-id}`
2. [ ] - `p1` - System displays {initial state} - `inst-{step-id}`
3. [ ] - `p1` - Actor performs {action} - `inst-{step-id}`
4. [ ] - `p1` - **IF** {condition} - `inst-{step-id}`
   1. [ ] - `p1` - System {action if true} - `inst-{step-id}`
5. [ ] - `p1` - **ELSE** - `inst-{step-id}`
   1. [ ] - `p1` - System {action if false} - `inst-{step-id}`
6. [ ] - `p1` - API: `{METHOD} /api/v1/mobile/{path}` (request/response summary) - `inst-{step-id}`
7. [ ] - `p1` - DB: `{OPERATION}` {table} ({key columns}) - `inst-{step-id}`
8. [ ] - `p1` - **RETURN** {result displayed to user} - `inst-{step-id}`

### 2.2 {Alternative Flow Name}

- [ ] `p2` - **ID**: `cpt-{subapp}-flow-{feature-slug}-{slug}`

**Actor**: `cpt-{platform}-actor-{slug}`

**Trigger**: {What triggers this alternative flow}

**Steps**:
1. [ ] - `p2` - {Step 1} - `inst-{step-id}`
2. [ ] - `p2` - {Step 2} - `inst-{step-id}`

## 3. Platform Implementation (CDSL)

### 3.1 KMP Shared Logic

- [ ] `p1` - **ID**: `cpt-{subapp}-algo-{feature-slug}-kmp`

**Location**: `constructor-sdk/feature/{subapp}/`

**ViewModel Steps**:
1. [ ] - `p1` - Receive intent from UI - `inst-kmp-1`
2. [ ] - `p1` - Call use case - `inst-kmp-2`
3. [ ] - `p1` - Update state based on result - `inst-kmp-3`
4. [ ] - `p1` - Emit side effects if needed - `inst-kmp-4`

**Use Case Steps**:
1. [ ] - `p1` - Validate input parameters - `inst-kmp-uc-1`
2. [ ] - `p1` - Call repository method - `inst-kmp-uc-2`
3. [ ] - `p1` - **TRY** - `inst-kmp-uc-3`
   1. [ ] - `p1` - Transform result to domain model - `inst-kmp-uc-3a`
4. [ ] - `p1` - **CATCH** {error} - `inst-kmp-uc-4`
   1. [ ] - `p1` - Map error to domain error - `inst-kmp-uc-4a`
5. [ ] - `p1` - **RETURN** Result<{DomainType}> - `inst-kmp-uc-5`

**Repository Steps**:
1. [ ] - `p1` - Check local cache - `inst-kmp-repo-1`
2. [ ] - `p1` - **IF** cache valid - `inst-kmp-repo-2`
   1. [ ] - `p1` - **RETURN** cached data - `inst-kmp-repo-2a`
3. [ ] - `p1` - **ELSE** - `inst-kmp-repo-3`
   1. [ ] - `p1` - Fetch from API - `inst-kmp-repo-3a`
   2. [ ] - `p1` - Store in local cache - `inst-kmp-repo-3b`
   3. [ ] - `p1` - **RETURN** fresh data - `inst-kmp-repo-3c`

### 3.2 Android UI

- [ ] `p1` - **ID**: `cpt-{subapp}-algo-{feature-slug}-android`

**Location**: `android-app/feature/{subapp}/ui/`

**Compose Screen Steps**:
1. [ ] - `p1` - Collect state from ViewModel - `inst-android-1`
2. [ ] - `p1` - Render UI based on state - `inst-android-2`
3. [ ] - `p1` - **WHEN** user action - `inst-android-3`
   1. [ ] - `p1` - Send intent to ViewModel - `inst-android-3a`
4. [ ] - `p1` - **WHEN** side effect received - `inst-android-4`
   1. [ ] - `p1` - Handle navigation/snackbar/dialog - `inst-android-4a`

### 3.3 iOS UI

- [ ] `p1` - **ID**: `cpt-{subapp}-algo-{feature-slug}-ios`

**Location**: `ios-app/Features/{SubApp}/Views/`

**SwiftUI View Steps**:
1. [ ] - `p1` - Observe state from ViewModel - `inst-ios-1`
2. [ ] - `p1` - Render body based on state - `inst-ios-2`
3. [ ] - `p1` - **WHEN** user action - `inst-ios-3`
   1. [ ] - `p1` - Call ViewModel method - `inst-ios-3a`
4. [ ] - `p1` - **WHEN** side effect received - `inst-ios-4`
   1. [ ] - `p1` - Handle navigation/alert/sheet - `inst-ios-4a`

### 3.4 WebView Integration (if applicable)

- [ ] `p2` - **ID**: `cpt-{subapp}-algo-{feature-slug}-webview`

**WebView URL**: `{webview-base-url}/{path}`

**Native → WebView**:
1. [ ] - `p2` - Load WebView with URL + auth token - `inst-wv-1`
2. [ ] - `p2` - Inject JS bridge - `inst-wv-2`

**WebView → Native**:
1. [ ] - `p2` - **WHEN** WebView calls `native.{method}()` - `inst-wv-3`
   1. [ ] - `p2` - Parse parameters - `inst-wv-3a`
   2. [ ] - `p2` - Execute native action - `inst-wv-3b`
   3. [ ] - `p2` - Return result to WebView - `inst-wv-3c`

## 4. States (CDSL)

### 4.1 {Feature} Screen State Machine

- [ ] `p1` - **ID**: `cpt-{subapp}-state-{feature-slug}`

**States**: Loading, Content, Error, Empty

**Initial State**: Loading

**Transitions**:
1. [ ] - `p1` - **FROM** Loading **TO** Content **WHEN** data loaded successfully - `inst-state-1`
2. [ ] - `p1` - **FROM** Loading **TO** Error **WHEN** API error - `inst-state-2`
3. [ ] - `p1` - **FROM** Loading **TO** Empty **WHEN** no data available - `inst-state-3`
4. [ ] - `p1` - **FROM** Error **TO** Loading **WHEN** user taps retry - `inst-state-4`
5. [ ] - `p1` - **FROM** Content **TO** Loading **WHEN** user pulls to refresh - `inst-state-5`

## 5. Definitions of Done

### 5.1 {DoD Title 1}

- [ ] `p1` - **ID**: `cpt-{subapp}-dod-{feature-slug}-{slug}`

The system **MUST** {clear description of what to implement}.

**Implements**:
- `cpt-{subapp}-flow-{feature-slug}-{slug}`

**Touches**:
- **KMP**: `{ViewModel}`, `{UseCase}`, `{Repository}`
- **Android**: `{Screen}`, `{Component}`
- **iOS**: `{View}`, `{Component}`
- **API**: `{METHOD} {/path}`

**Verification**:
- [ ] Unit tests for use case
- [ ] UI tests for screen
- [ ] Integration test for API

### 5.2 {DoD Title 2}

- [ ] `p2` - **ID**: `cpt-{subapp}-dod-{feature-slug}-{slug}`

The system **MUST** {description}.

**Implements**:
- `cpt-{subapp}-flow-{feature-slug}-{slug}`

**Touches**:
- **KMP**: {modules}
- **Android**: {components}
- **iOS**: {components}

## 6. Acceptance Criteria

### 6.1 Functional

- [ ] {Testable criterion for this feature}
- [ ] {Another testable criterion}

### 6.2 Platform-Specific

**Android:**
- [ ] {Android-specific criterion}

**iOS:**
- [ ] {iOS-specific criterion}

### 6.3 Performance

- [ ] {Performance criterion with measurable threshold}

### 6.4 Offline (if applicable)

- [ ] {Offline behavior criterion}

## 7. Traceability

- **Epic PRD**: [../PRD.md](../PRD.md)
- **Epic DESIGN**: [../DESIGN.md](../DESIGN.md)
- **DECOMPOSITION**: [../DECOMPOSITION.md](../DECOMPOSITION.md)
- **Implementation**:
  - KMP: [constructor-sdk/feature/{subapp}/IMPL.md](../../../../constructor-sdk/feature/{subapp}/IMPL.md)
  - Android: [android-app/feature/{subapp}/IMPL.md](../../../../android-app/feature/{subapp}/IMPL.md)
  - iOS: [ios-app/Features/{SubApp}/IMPL.md](../../../../ios-app/Features/{SubApp}/IMPL.md)

<!-- /@cpt:blueprint -->
