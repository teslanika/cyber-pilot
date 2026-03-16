#!/bin/bash
# Mobile SuperApp Kit Uninstaller
# Removes the kit and restores default SDLC kit

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KIT_NAME="mobile-superapp"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "=========================================="
echo "  Mobile SuperApp Kit Uninstaller"
echo "=========================================="
echo ""

PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
CYPILOT_DIR="$PROJECT_ROOT/cypilot"

# Remove from .gen/kits
GEN_KIT="$CYPILOT_DIR/.gen/kits/$KIT_NAME"
if [ -L "$GEN_KIT" ] || [ -d "$GEN_KIT" ]; then
    rm -rf "$GEN_KIT"
    echo -e "${GREEN}Removed: $GEN_KIT${NC}"
fi

# Remove from global kits
GLOBAL_KIT="$HOME/.cypilot/kits/$KIT_NAME"
if [ -d "$GLOBAL_KIT" ]; then
    read -p "Remove global kit at $GLOBAL_KIT? [y/N]: " REMOVE_GLOBAL
    if [[ "$REMOVE_GLOBAL" =~ ^[Yy]$ ]]; then
        rm -rf "$GLOBAL_KIT"
        echo -e "${GREEN}Removed: $GLOBAL_KIT${NC}"
    fi
fi

# Restore artifacts.toml
ARTIFACTS_FILE="$CYPILOT_DIR/config/artifacts.toml"
if [ -f "$ARTIFACTS_FILE" ]; then
    if grep -q 'kit = "mobile-superapp"' "$ARTIFACTS_FILE"; then
        read -p "Restore artifacts.toml to use cypilot-sdlc? [y/N]: " RESTORE
        if [[ "$RESTORE" =~ ^[Yy]$ ]]; then
            sed -i.tmp 's/kit = "mobile-superapp"/kit = "cypilot-sdlc"/' "$ARTIFACTS_FILE"
            rm -f "$ARTIFACTS_FILE.tmp"
            echo -e "${GREEN}Restored artifacts.toml to use cypilot-sdlc${NC}"
        fi
    fi
fi

# Check for backup
if [ -f "$ARTIFACTS_FILE.bak" ]; then
    read -p "Found backup artifacts.toml.bak. Restore from backup? [y/N]: " USE_BACKUP
    if [[ "$USE_BACKUP" =~ ^[Yy]$ ]]; then
        mv "$ARTIFACTS_FILE.bak" "$ARTIFACTS_FILE"
        echo -e "${GREEN}Restored from backup${NC}"
    fi
fi

echo ""
echo -e "${GREEN}Uninstall complete!${NC}"
echo "The standard SDLC kit is now active."
echo ""
echo "Note: The kit source files in cypilot/kits/mobile-superapp/ were NOT removed."
echo "Delete them manually if needed."
