# Technical Design — {SubApp Name} SubApp

<!-- @cpt:blueprint name="DESIGN-SUBAPP" kind="template" -->

## Table of Contents

<!-- toc -->

<!-- /toc -->

## 1. SubApp Overview

### 1.1 Purpose

{1-2 paragraphs: What this SubApp provides, what user problems it solves, how it fits into the SuperApp ecosystem.}

**Parent Platform Design**: [../DESIGN.md](../DESIGN.md)

### 1.2 Capabilities

Capabilities from SubApp PRD with design allocation:

| Capability ID | Capability | Design Response |
|---------------|------------|-----------------|
| `cpt-{subapp}-fr-{slug}` | {Capability description} | {How SubApp architecture addresses this} |

### 1.3 Architecture Drivers

**ADRs**: `cpt-{subapp}-adr-{slug}`

#### NFR Allocation

| NFR ID | NFR Summary | Allocated To | Design Response |
|--------|-------------|--------------|-----------------|
| `cpt-{subapp}-nfr-{slug}` | {Brief NFR description} | {Module/component} | {How this design element realizes the NFR} |

## 2. Module Structure

### 2.1 Module Overview

```
{subapp}/
├── constructor-sdk/feature/{subapp}/     # KMP Shared Logic
│   ├── domain/                            # Domain entities
│   ├── data/                              # Repository implementations
│   └── presentation/                      # ViewModels (MVI)
│
├── android-app/feature/{subapp}/          # Android UI
│   ├── ui/                                # Compose components
│   └── navigation/                        # Navigation graph
│
└── ios-app/Features/{SubApp}/             # iOS UI
    ├── Views/                             # SwiftUI views
    └── Navigation/                        # Coordinators
```

### 2.2 KMP Modules

- [ ] `p1` - **ID**: `cpt-{subapp}-component-kmp-domain`

#### Domain Module

**Location**: `constructor-sdk/feature/{subapp}/domain/`

**Responsibility**: Core business entities and rules for {SubApp}

**Contains**:
- Domain entities
- Repository interfaces
- Use case definitions

#### Data Module

- [ ] `p1` - **ID**: `cpt-{subapp}-component-kmp-data`

**Location**: `constructor-sdk/feature/{subapp}/data/`

**Responsibility**: Data layer implementation

**Contains**:
- Repository implementations
- API clients
- Local data sources
- DTOs and mappers

#### Presentation Module

- [ ] `p1` - **ID**: `cpt-{subapp}-component-kmp-presentation`

**Location**: `constructor-sdk/feature/{subapp}/presentation/`

**Responsibility**: State management (MVI pattern)

**Contains**:
- ViewModels
- UI State classes
- UI Events
- Side Effects

### 2.3 Android Modules

- [ ] `p1` - **ID**: `cpt-{subapp}-component-android-ui`

**Location**: `android-app/feature/{subapp}/`

**Responsibility**: Android-specific UI implementation

**Contains**:
- Jetpack Compose screens
- Compose components
- Navigation graph
- Android-specific resources

**Dependencies**:
- `constructor-sdk/feature/{subapp}` (KMP shared)
- `android-app/common/ui` (design system)
- `android-app/common/navigation`

### 2.4 iOS Modules

- [ ] `p1` - **ID**: `cpt-{subapp}-component-ios-ui`

**Location**: `ios-app/Features/{SubApp}/`

**Responsibility**: iOS-specific UI implementation

**Contains**:
- SwiftUI views
- View components
- Navigation coordinators
- iOS-specific resources

**Dependencies**:
- `ConstructorSDK` (KMP framework)
- `ios-app/Common/UI` (design system)
- `ios-app/Common/Navigation`

## 3. Navigation Architecture

### 3.1 Navigation Graph

- [ ] `p2` - **ID**: `cpt-{subapp}-component-navigation`

```mermaid
flowchart TB
    subgraph SubApp["{SubApp} SubApp"]
        Entry["Entry Point"]
        Screen1["Screen 1"]
        Screen2["Screen 2"]
        Screen3["Screen 3"]
    end
    
    Entry --> Screen1
    Screen1 --> Screen2
    Screen1 --> Screen3
    Screen2 --> Screen3
```

**Screen Inventory:**

| Screen | Route | Description | Implementation |
|--------|-------|-------------|----------------|
| {Screen1} | `/{subapp}/{screen1}` | {Description} | Native / WebView |
| {Screen2} | `/{subapp}/{screen2}` | {Description} | Native / WebView |

### 3.2 Deep Links

- [ ] `p2` - **ID**: `cpt-{subapp}-deeplink-schema`

| Deep Link | Target Screen | Parameters |
|-----------|---------------|------------|
| `constructor://{subapp}/{path}` | {Screen} | `{param1}`, `{param2}` |

**Deep Link Handling Flow:**

1. Host app receives deep link
2. SubApp Registry routes to {SubApp}
3. {SubApp} navigation handles internal routing
4. Target screen displayed with parameters

## 4. State Management

### 4.1 MVI Pattern

- [ ] `p1` - **ID**: `cpt-{subapp}-principle-mvi`

```
┌──────────────────────────────────────────────────────────────┐
│                        VIEW (UI)                              │
│  ┌────────────────┐          ┌────────────────┐              │
│  │  Compose/SwiftUI│  ←state─ │    State       │              │
│  │     Screen     │          │   (immutable)  │              │
│  └───────┬────────┘          └────────────────┘              │
│          │ intent                    ↑                        │
│          ↓                           │                        │
│  ┌────────────────────────────────────────────────────────┐  │
│  │                    VIEWMODEL                            │  │
│  │   Intent → Reducer → State                              │  │
│  │                ↓                                        │  │
│  │          Side Effects → Repository                      │  │
│  └────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────┘
```

**State Structure:**

```kotlin
data class {SubApp}State(
    val isLoading: Boolean = false,
    val data: List<{Entity}> = emptyList(),
    val error: String? = null,
    // SubApp-specific state fields
)

sealed class {SubApp}Intent {
    object Load : {SubApp}Intent()
    data class Select(val id: String) : {SubApp}Intent()
    // SubApp-specific intents
}

sealed class {SubApp}Effect {
    data class Navigate(val route: String) : {SubApp}Effect()
    data class ShowError(val message: String) : {SubApp}Effect()
    // SubApp-specific side effects
}
```

### 4.2 State Persistence

- [ ] `p2` - **ID**: `cpt-{subapp}-component-state-persistence`

**Persisted State:**
- {List state that needs persistence}

**Transient State:**
- {List state that is not persisted}

**Persistence Strategy:**
- Local database: SQLDelight for structured data
- Preferences: DataStore/UserDefaults for simple values
- Memory cache: In-memory for session data

## 5. Domain Model

### 5.1 Core Entities

- [ ] `p1` - **ID**: `cpt-{subapp}-entity-{slug}`

| Entity | Description | Location |
|--------|-------------|----------|
| `{Entity1}` | {Purpose} | `constructor-sdk/feature/{subapp}/domain/model/` |

**Entity Relationships:**

```mermaid
erDiagram
    Entity1 ||--o{ Entity2 : contains
    Entity1 }|--|| Entity3 : references
```

### 5.2 Repository Interfaces

- [ ] `p1` - **ID**: `cpt-{subapp}-repo-{slug}`

```kotlin
interface {SubApp}Repository {
    suspend fun getItems(): Result<List<{Entity}>>
    suspend fun getItem(id: String): Result<{Entity}>
    suspend fun saveItem(item: {Entity}): Result<Unit>
    // SubApp-specific operations
}
```

## 6. API Layer

### 6.1 BFF Endpoints

- [ ] `p2` - **ID**: `cpt-{subapp}-api-{slug}`

| Method | Endpoint | Description | Request | Response |
|--------|----------|-------------|---------|----------|
| `GET` | `/api/v1/mobile/{subapp}/{resource}` | {Description} | — | `List<{DTO}>` |
| `GET` | `/api/v1/mobile/{subapp}/{resource}/{id}` | {Description} | — | `{DTO}` |
| `POST` | `/api/v1/mobile/{subapp}/{resource}` | {Description} | `{RequestDTO}` | `{DTO}` |

### 6.2 WebSocket Connections

{If applicable — for real-time features}

- [ ] `p3` - **ID**: `cpt-{subapp}-ws-{slug}`

| Connection | Purpose | Events |
|------------|---------|--------|
| `wss://{host}/{subapp}/events` | {Purpose} | `{event1}`, `{event2}` |

## 7. Kernel Integration

### 7.1 Required Kernel Services

| Service | Usage | Criticality |
|---------|-------|-------------|
| Auth | {How SubApp uses auth} | p1 |
| Storage | {How SubApp uses storage} | p1 |
| Network | {How SubApp uses network} | p1 |
| Notifications | {How SubApp uses notifications} | p2 |

### 7.2 SubApp Contract Implementation

```kotlin
class {SubApp}SubApp : SubApp {
    override val id = "{subapp}"
    override val name = "{SubApp Name}"
    override val version = "1.0.0"
    
    private lateinit var kernel: Kernel
    
    override fun initialize(kernel: Kernel) {
        this.kernel = kernel
        // Initialize DI, repositories, etc.
    }
    
    override fun start(): SubAppScreen {
        return {SubApp}EntryScreen(kernel)
    }
    
    override fun handleDeepLink(uri: Uri): Boolean {
        // Handle deep links for this SubApp
    }
    
    override fun onBackground() {
        // Cleanup, save state
    }
    
    override fun onForeground() {
        // Restore, refresh data
    }
    
    override fun dispose() {
        // Release resources
    }
}
```

## 8. Traceability

- **SubApp PRD**: [PRD.md](./PRD.md)
- **Platform DESIGN**: [../DESIGN.md](../DESIGN.md)
- **ADRs**: [adr/](./adr/)
- **DECOMPOSITION**: [DECOMPOSITION.md](./DECOMPOSITION.md)
- **Epics**: [screens/](./screens/), [capabilities/](./capabilities/), [flows/](./flows/)

<!-- /@cpt:blueprint -->
