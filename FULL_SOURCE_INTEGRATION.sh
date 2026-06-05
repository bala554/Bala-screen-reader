#!/bin/bash

###############################################################################
# FULL TALKBACK SOURCE CODE INTEGRATION SCRIPT
# 
# This script downloads the complete Google TalkBack source code and 
# integrates all modules into the Bala Screen Reader project.
#
# Usage: bash FULL_SOURCE_INTEGRATION.sh
###############################################################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}TalkBack Full Source Integration${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Step 1: Check prerequisites
echo -e "${YELLOW}[1/8] Checking prerequisites...${NC}"

if ! command -v git &> /dev/null; then
    echo -e "${RED}ERROR: git is not installed${NC}"
    exit 1
fi

if ! command -v java &> /dev/null; then
    echo -e "${RED}ERROR: Java is not installed${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Prerequisites OK${NC}"
echo ""

# Step 2: Create temporary directory
echo -e "${YELLOW}[2/8] Creating temporary directory...${NC}"
TEMP_DIR="/tmp/talkback-source-$$"
mkdir -p "$TEMP_DIR"
echo -e "${GREEN}✓ Temp directory: $TEMP_DIR${NC}"
echo ""

# Step 3: Clone TalkBack repository (shallow clone to save time/space)
echo -e "${YELLOW}[3/8] Cloning Google TalkBack repository (this may take 1-2 minutes)...${NC}"
cd "$TEMP_DIR"
git clone --depth 1 --branch master https://github.com/google/talkback.git talkback-repo
echo -e "${GREEN}✓ Repository cloned${NC}"
echo ""

# Step 4: Create project directory structure
echo -e "${YELLOW}[4/8] Creating project directory structure...${NC}"
cd "$SCRIPT_DIR"

# Create all necessary directories
mkdir -p braille/{common,interfaces,brailleime,brailledisplay,brailleimeanalytics,translate,brltty}
mkdir -p material/{flags,preference,theme,preference/compose}
mkdir -p proguard/src/main/java
mkdir -p utils/src/main/java
mkdir -p talkback/src/main/{java,res,assets}
mkdir -p talkback/src/phone/{java,res}
mkdir -p talkback/src/wear/{java,res}

echo -e "${GREEN}✓ Directory structure created${NC}"
echo ""

# Step 5: Copy braille modules
echo -e "${YELLOW}[5/8] Copying braille modules (this may take a few minutes)...${NC}"

copy_module() {
    local module_name=$1
    local source_dir=$2
    local dest_dir=$3
    
    if [ -d "$source_dir" ]; then
        cp -r "$source_dir"/* "$dest_dir/" 2>/dev/null || true
        echo -e "${GREEN}✓ Copied $module_name${NC}"
    else
        echo -e "${YELLOW}⚠ Skipped $module_name (not found)${NC}"
    fi
}

copy_module "braille/common" "$TEMP_DIR/talkback-repo/braille/common" "braille/common"
copy_module "braille/interfaces" "$TEMP_DIR/talkback-repo/braille/interfaces" "braille/interfaces"
copy_module "braille/brailleime" "$TEMP_DIR/talkback-repo/braille/brailleime" "braille/brailleime"
copy_module "braille/brailledisplay" "$TEMP_DIR/talkback-repo/braille/brailledisplay" "braille/brailledisplay"
copy_module "braille/brailleimeanalytics" "$TEMP_DIR/talkback-repo/braille/brailleimeanalytics" "braille/brailleimeanalytics"
copy_module "braille/translate" "$TEMP_DIR/talkback-repo/braille/translate" "braille/translate"
copy_module "braille/brltty" "$TEMP_DIR/talkback-repo/braille/brltty" "braille/brltty"

echo ""

# Step 6: Copy material modules
echo -e "${YELLOW}[6/8] Copying material modules...${NC}"

copy_module "material/flags" "$TEMP_DIR/talkback-repo/material/flags" "material/flags"
copy_module "material/preference" "$TEMP_DIR/talkback-repo/material/preference" "material/preference"
copy_module "material/preference/compose" "$TEMP_DIR/talkback-repo/material/preference/compose" "material/preference/compose"
copy_module "material/theme" "$TEMP_DIR/talkback-repo/material/theme" "material/theme"

echo ""

# Step 7: Copy core modules
echo -e "${YELLOW}[7/8] Copying core modules (utils, proguard, talkback)...${NC}"

copy_module "utils" "$TEMP_DIR/talkback-repo/utils" "utils"
copy_module "proguard" "$TEMP_DIR/talkback-repo/proguard" "proguard"
copy_module "talkback" "$TEMP_DIR/talkback-repo/talkback" "talkback"

echo ""

# Step 8: Cleanup and summary
echo -e "${YELLOW}[8/8] Cleaning up...${NC}"
rm -rf "$TEMP_DIR"
echo -e "${GREEN}✓ Temp directory removed${NC}"
echo ""

# Verify integration
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}INTEGRATION COMPLETE!${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Count Java files
JAVA_COUNT=$(find . -name "*.java" -o -name "*.kt" | wc -l)
RES_COUNT=$(find . -path "*/res/*" -type f | wc -l)

echo -e "${GREEN}Summary:${NC}"
echo "  - Java/Kotlin files: $JAVA_COUNT"
echo "  - Resource files: $RES_COUNT"
echo ""

# Show directory structure
echo -e "${GREEN}Directory Structure:${NC}"
tree -L 2 -d 2>/dev/null || find . -maxdepth 2 -type d | head -20

echo ""
echo -e "${YELLOW}Next Steps:${NC}"
echo "1. Run: chmod +x gradlew"
echo "2. Run: ./gradlew clean"
echo "3. Run: ./gradlew build --info"
echo "4. Run: ./gradlew assembleDebug"
echo ""
echo -e "${GREEN}Happy Building! 🚀${NC}"
