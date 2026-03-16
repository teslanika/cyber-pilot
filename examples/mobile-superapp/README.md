# Mobile SuperApp Kit

Custom Cypilot kit for mobile application development with multi-level requirement traceability.

## Documentation

- **[Traceability Guide](docs/TRACEABILITY.md)** — How requirement traceability works
- **[Detailed Description](docs/DESCRIPTION.md)** — Full kit description

## What This Kit Provides

### Multi-Level Documentation Hierarchy

```
L0: Platform     → Shared Kernel (Auth, Push, Deep Links, NFRs)
L1: SubApp       → Domain apps (Student, Proctor, Groups)
L2: Epic         → Screens, Capabilities, Flows
L3: Feature      → CDSL specifications
```

### Cascading Requirement Traceability

```
Platform FR (cpt-superapp-fr-*)
      │ refined-by
      ▼
SubApp FR (cpt-student-fr-*)
      │ detailed-by
      ▼
Epic FR (cpt-student-epic-{epic}-fr-*)
      │ specified-by
      ▼
Feature (cpt-student-feature-*)
      │ implemented-by
      ▼
Code (@cpt-impl markers)
```

### Templates (15 total)

| Category | Templates |
|----------|-----------|
| PRD | PRD-SUBAPP, PRD-EPIC |
| DESIGN | DESIGN-PLATFORM, DESIGN-SUBAPP, DESIGN-EPIC |
| DECOMPOSITION | DECOMPOSITION-PLATFORM, DECOMPOSITION-SUBAPP, DECOMPOSITION-EPIC |
| Implementation | FEATURE-MOBILE, IMPL-KMP, IMPL-ANDROID, IMPL-IOS |

## Directory Structure

```
mobile-superapp/
├── README.md              # This file
├── SKILL.md               # Kit capabilities
├── AGENTS.md              # Agent rules
├── constraints.toml       # Traceability rules
├── blueprints/            # All templates
└── docs/                  # Documentation
    ├── TRACEABILITY.md    # Traceability guide
    └── DESCRIPTION.md     # Full description
```

## Installation

To use this kit in your project:

```bash
# Copy kit to your project
cp -r examples/mobile-superapp/blueprints your-project/cypilot/kits/mobile-superapp/
cp examples/mobile-superapp/constraints.toml your-project/cypilot/kits/mobile-superapp/

# Update artifacts.toml
# Change: kit = "cypilot-sdlc" to kit = "mobile-superapp"
```

## Use Cases

This kit is designed for mobile applications with:

- **Platform layer** — shared authentication, push notifications, deep links
- **Multiple SubApps** — modular apps within a SuperApp container
- **Screen-level requirements** — detailed UI/UX specifications
- **Cross-platform implementation** — KMP shared logic + native UI (iOS/Android)

---

**Version**: 2.0  
**License**: Apache-2.0
