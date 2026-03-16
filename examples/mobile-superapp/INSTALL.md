# Mobile SuperApp Kit — Installation Guide

## Overview

This kit **extends** the standard SDLC kit with mobile-specific features:
- Multi-level PRD hierarchy (Platform → SubApp → Epic)
- Cascading FR traceability across levels
- Mobile-specific templates (KMP, Android, iOS)

**Important**: This kit does NOT replace the SDLC kit. It works alongside it.

---

## Installation Options

### Option 1: Symlink (Recommended for Development)

Creates a symbolic link from your project to the cypilot kits folder.

```bash
# Navigate to your project
cd /path/to/mobile-superapp

# Create symlink to cypilot kits directory
ln -s "$(pwd)/cypilot/kits/mobile-superapp" \
      "$(pwd)/cypilot/.gen/kits/mobile-superapp"
```

**Pros**: Changes to kit are immediately reflected
**Cons**: Only works in this project

### Option 2: Copy to Global Kits (For Team Sharing)

```bash
# Copy kit to cypilot global kits folder
cp -r cypilot/kits/mobile-superapp ~/.cypilot/kits/

# Or if using project-local cypilot
cp -r cypilot/kits/mobile-superapp cypilot/.gen/kits/
```

### Option 3: Git Submodule (For Versioned Sharing)

```bash
# Add as submodule (if kit is in separate repo)
git submodule add <kit-repo-url> cypilot/kits/mobile-superapp
```

---

## Configuration

### 1. Register Kit in artifacts.toml

Edit `cypilot/config/artifacts.toml`:

```toml
[[systems]]
name = "Constructor Mobile SuperApp"
slug = "superapp"
kit = "mobile-superapp"  # Change from "cypilot-sdlc"
artifacts_dir = "architecture"
```

### 2. Verify Kit Structure

```
cypilot/kits/mobile-superapp/
├── SKILL.md              # Kit capabilities
├── AGENTS.md             # Agent navigation rules
├── INSTALL.md            # This file
├── constraints.toml      # Traceability & validation rules
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
    └── TRACEABILITY.md
```

---

## Traceability Setup

The key feature of this kit is **cascading FR traceability**:

```
Platform FR → SubApp FR → Epic FR → Feature → Code
```

### Enable Traceability Validation

The `constraints.toml` file defines validation rules. These are automatically applied when you run:

```bash
cpt validate --kit=mobile-superapp
```

### Traceability Rules Location

All rules are in `cypilot/kits/mobile-superapp/constraints.toml`:

| Section | Purpose |
|---------|---------|
| `[identifiers.*]` | ID patterns and cross-references |
| `[traceability]` | Document-level trace relationships |
| `[traceability.requirements]` | FR cascade rules |
| `[validation.rules]` | Coverage checks |

---

## Usage After Installation

### Creating New SubApp PRD

```bash
# Use the PRD-SUBAPP template
cpt create PRD --template=PRD-SUBAPP --path=subapps/student/PRD.md
```

### Creating New Epic PRD

```bash
# Use the PRD-EPIC template  
cpt create PRD --template=PRD-EPIC --path=subapps/student/screens/home/PRD.md
```

### Validating Traceability

```bash
# Check all traceability rules
cpt validate --check=traceability

# Check specific cascade levels
cpt validate --check=platform-fr-coverage
cpt validate --check=subapp-fr-coverage
cpt validate --check=epic-fr-coverage
```

---

## Rollback

To return to standard SDLC kit:

1. Edit `cypilot/config/artifacts.toml`:
   ```toml
   kit = "cypilot-sdlc"  # Restore original
   ```

2. Remove symlink (if created):
   ```bash
   rm cypilot/.gen/kits/mobile-superapp
   ```

The SDLC kit remains untouched and fully functional.

---

## Compatibility

| Component | Version |
|-----------|---------|
| Cypilot | 1.x+ |
| Extends | SDLC kit |
| Conflicts | None |

This kit uses `extends = "sdlc"` in constraints.toml, meaning it inherits all SDLC kit definitions and only adds/overrides mobile-specific rules.
