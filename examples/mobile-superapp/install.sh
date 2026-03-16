#!/bin/bash
# Mobile SuperApp Kit Installer
# This script installs the mobile-superapp kit WITHOUT modifying the default SDLC kit

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KIT_NAME="mobile-superapp"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=========================================="
echo "  Mobile SuperApp Kit Installer"
echo "=========================================="
echo ""

# Detect project root (parent of cypilot folder)
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
CYPILOT_DIR="$PROJECT_ROOT/cypilot"

echo "Project root: $PROJECT_ROOT"
echo "Cypilot dir:  $CYPILOT_DIR"
echo ""

# Check if cypilot directory exists
if [ ! -d "$CYPILOT_DIR" ]; then
    echo -e "${RED}Error: cypilot directory not found at $CYPILOT_DIR${NC}"
    exit 1
fi

# Determine installation method
echo "Select installation method:"
echo "  1) Symlink (recommended for development)"
echo "  2) Copy to .gen/kits (for local use)"
echo "  3) Copy to ~/.cypilot/kits (for global use)"
echo ""
read -p "Enter choice [1-3]: " CHOICE

case $CHOICE in
    1)
        # Symlink method
        TARGET_DIR="$CYPILOT_DIR/.gen/kits"
        mkdir -p "$TARGET_DIR"
        
        # Remove existing if present
        if [ -L "$TARGET_DIR/$KIT_NAME" ] || [ -d "$TARGET_DIR/$KIT_NAME" ]; then
            echo -e "${YELLOW}Removing existing kit at $TARGET_DIR/$KIT_NAME${NC}"
            rm -rf "$TARGET_DIR/$KIT_NAME"
        fi
        
        ln -s "$SCRIPT_DIR" "$TARGET_DIR/$KIT_NAME"
        echo -e "${GREEN}Created symlink: $TARGET_DIR/$KIT_NAME -> $SCRIPT_DIR${NC}"
        ;;
    2)
        # Copy to local .gen/kits
        TARGET_DIR="$CYPILOT_DIR/.gen/kits/$KIT_NAME"
        
        if [ -d "$TARGET_DIR" ]; then
            echo -e "${YELLOW}Removing existing kit at $TARGET_DIR${NC}"
            rm -rf "$TARGET_DIR"
        fi
        
        mkdir -p "$TARGET_DIR"
        cp -r "$SCRIPT_DIR"/* "$TARGET_DIR/"
        echo -e "${GREEN}Copied kit to: $TARGET_DIR${NC}"
        ;;
    3)
        # Copy to global ~/.cypilot/kits
        TARGET_DIR="$HOME/.cypilot/kits/$KIT_NAME"
        
        if [ -d "$TARGET_DIR" ]; then
            echo -e "${YELLOW}Removing existing kit at $TARGET_DIR${NC}"
            rm -rf "$TARGET_DIR"
        fi
        
        mkdir -p "$TARGET_DIR"
        cp -r "$SCRIPT_DIR"/* "$TARGET_DIR/"
        echo -e "${GREEN}Copied kit to: $TARGET_DIR${NC}"
        ;;
    *)
        echo -e "${RED}Invalid choice${NC}"
        exit 1
        ;;
esac

echo ""

# Update artifacts.toml
ARTIFACTS_FILE="$CYPILOT_DIR/config/artifacts.toml"
if [ -f "$ARTIFACTS_FILE" ]; then
    echo "Checking artifacts.toml..."
    
    if grep -q 'kit = "cypilot-sdlc"' "$ARTIFACTS_FILE"; then
        read -p "Update artifacts.toml to use mobile-superapp kit? [y/N]: " UPDATE_ARTIFACTS
        if [[ "$UPDATE_ARTIFACTS" =~ ^[Yy]$ ]]; then
            # Create backup
            cp "$ARTIFACTS_FILE" "$ARTIFACTS_FILE.bak"
            
            # Update kit reference
            sed -i.tmp 's/kit = "cypilot-sdlc"/kit = "mobile-superapp"/' "$ARTIFACTS_FILE"
            rm -f "$ARTIFACTS_FILE.tmp"
            
            echo -e "${GREEN}Updated artifacts.toml (backup: artifacts.toml.bak)${NC}"
        else
            echo -e "${YELLOW}Skipped artifacts.toml update${NC}"
            echo "To enable the kit, manually change 'kit = \"cypilot-sdlc\"' to 'kit = \"mobile-superapp\"'"
        fi
    elif grep -q 'kit = "mobile-superapp"' "$ARTIFACTS_FILE"; then
        echo -e "${GREEN}artifacts.toml already uses mobile-superapp kit${NC}"
    fi
fi

echo ""
echo "=========================================="
echo -e "${GREEN}  Installation Complete!${NC}"
echo "=========================================="
echo ""
echo "Next steps:"
echo "  1. Verify: cpt validate --kit=mobile-superapp"
echo "  2. Create SubApp PRD: Use PRD-SUBAPP template"
echo "  3. Create Epic PRD: Use PRD-EPIC template"
echo ""
echo "To rollback:"
echo "  - Change kit = \"mobile-superapp\" back to \"cypilot-sdlc\" in artifacts.toml"
echo "  - Remove symlink/copy from .gen/kits/"
echo ""
