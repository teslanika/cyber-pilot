# Mobile SuperApp Kit — Agent Rules

## Navigation Rules

### PRD Templates (with traceability)
ALWAYS open and follow `{cypilot_path}/kits/mobile-superapp/blueprints/PRD-SUBAPP.md` WHEN creating SubApp-level PRD

ALWAYS open and follow `{cypilot_path}/kits/mobile-superapp/blueprints/PRD-EPIC.md` WHEN creating Epic-level PRD

### DESIGN Templates
ALWAYS open and follow `{cypilot_path}/kits/mobile-superapp/blueprints/DESIGN-PLATFORM.md` WHEN creating Platform-level DESIGN

ALWAYS open and follow `{cypilot_path}/kits/mobile-superapp/blueprints/DESIGN-SUBAPP.md` WHEN creating SubApp-level DESIGN

ALWAYS open and follow `{cypilot_path}/kits/mobile-superapp/blueprints/DESIGN-EPIC.md` WHEN creating Epic-level DESIGN (screen, capability, flow)

### DECOMPOSITION Templates
ALWAYS open and follow `{cypilot_path}/kits/mobile-superapp/blueprints/DECOMPOSITION-PLATFORM.md` WHEN creating Platform DECOMPOSITION

ALWAYS open and follow `{cypilot_path}/kits/mobile-superapp/blueprints/DECOMPOSITION-SUBAPP.md` WHEN creating SubApp DECOMPOSITION

ALWAYS open and follow `{cypilot_path}/kits/mobile-superapp/blueprints/DECOMPOSITION-EPIC.md` WHEN creating Epic DECOMPOSITION

### FEATURE Templates
ALWAYS open and follow `{cypilot_path}/kits/mobile-superapp/blueprints/FEATURE-MOBILE.md` WHEN creating mobile FEATURE

### IMPL Templates
ALWAYS open and follow `{cypilot_path}/kits/mobile-superapp/blueprints/IMPL-KMP.md` WHEN creating KMP implementation reference

ALWAYS open and follow `{cypilot_path}/kits/mobile-superapp/blueprints/IMPL-ANDROID.md` WHEN creating Android implementation reference

ALWAYS open and follow `{cypilot_path}/kits/mobile-superapp/blueprints/IMPL-IOS.md` WHEN creating iOS implementation reference

### Validation
ALWAYS open and follow `{cypilot_path}/kits/mobile-superapp/constraints.toml` WHEN validating mobile-superapp artifacts

## Level Detection

WHEN artifact path matches `architecture/` → Platform level (L0)
WHEN artifact path matches `subapps/{subapp}/` (direct children) → SubApp level (L1)
WHEN artifact path matches `subapps/{subapp}/screens/{screen}/` → Epic level (L2, screen)
WHEN artifact path matches `subapps/{subapp}/capabilities/{capability}/` → Epic level (L2, capability)
WHEN artifact path matches `subapps/{subapp}/flows/{flow}/` → Epic level (L2, flow)
WHEN artifact path matches `subapps/{subapp}/*/{epic}/features/{feature}/` → Feature level (L3)

## Template Selection

| Level | PRD | DESIGN | DECOMPOSITION | FEATURE |
|-------|-----|--------|---------------|---------|
| L0: Platform | SDLC PRD | DESIGN-PLATFORM | DECOMPOSITION-PLATFORM | — |
| L1: SubApp | **PRD-SUBAPP** | DESIGN-SUBAPP | DECOMPOSITION-SUBAPP | — |
| L2: Epic | **PRD-EPIC** | DESIGN-EPIC | DECOMPOSITION-EPIC | — |
| L3: Feature | — | — | — | FEATURE-MOBILE |

## Traceability Rules

### FR Cascade Requirements

When creating SubApp PRD:
1. MUST include "Traces To Platform" table
2. Each SubApp FR SHOULD reference parent Platform FR
3. FRs without parent must be tagged `subapp-specific`

When creating Epic PRD:
1. MUST include "Traces To Parent Requirements" table
2. Each Epic FR SHOULD reference parent SubApp FR
3. FRs without parent must be tagged `epic-specific`

When creating FEATURE:
1. MUST include "Traces To" section with Epic FR references
2. Each DOD SHOULD trace back to Epic FR

### Validation Commands

```bash
# Validate FR traceability cascade
cpt validate --check=fr-cascade

# Check coverage of Platform FRs → SubApp FRs
cpt validate --check=platform-fr-coverage

# Check coverage of SubApp FRs → Epic FRs  
cpt validate --check=subapp-fr-coverage

# Check Feature implementation coverage
cpt validate --check=feature-impl-coverage
```
