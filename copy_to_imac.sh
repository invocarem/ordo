#!/bin/bash
set -e

# Simple script to copy production files to iMac via SSH
# Copies psalms.json and themes.json to iMac target folder

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Load environment variables
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

# Configuration
IMAC_HOST=${IMAC_HOST:-"chens-imac.local"}
IMAC_USER=${IMAC_USER:-"chen"}
IMAC_TARGET_DIR=${IMAC_TARGET_DIR:-"~/Downloads"}
IMAC_PROJECT_DIR=${IMAC_PROJECT_DIR:-"~/code/ordo"}
IMAC_PSALM_SERVICE_DIR=${IMAC_PSALM_SERVICE_DIR:-"~/code/ordo/ordo/Services/PsalmService"}
IMAC_LATIN_SERVICE_DIR=${IMAC_LATIN_SERVICE_DIR:-"~/code/ordo/ordo/Services/LatinService"}

print_status "🚀 Copying production files to iMac via SSH..."

# Check if required files exist
REQUIRED_FILES=("psalms.json" "themes.json")
MISSING_FILES=()

for file in "${REQUIRED_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        MISSING_FILES+=("$file")
    else
        print_success "Found $file"
    fi
done

if [ ${#MISSING_FILES[@]} -ne 0 ]; then
    print_error "Missing required files: ${MISSING_FILES[*]}"
    print_status "Please generate these files first:"
    echo "  docker build -f docker-support/Dockerfile ."
    exit 1
fi

# Check if SSH is available
if ! command -v ssh &> /dev/null; then
    print_error "SSH command not found"
    print_status "Please install OpenSSH client"
    exit 1
fi

# Test SSH connection to iMac
print_status "🔌 Testing SSH connection to $IMAC_USER@$IMAC_HOST..."
if ! ssh -o ConnectTimeout=10 -o BatchMode=yes "$IMAC_USER@$IMAC_HOST" "echo 'SSH connection successful'" > /dev/null 2>&1; then
    print_error "Cannot connect to iMac via SSH"
    print_status "Please ensure:"
    echo "  1. SSH is enabled on iMac (System Preferences > Sharing > Remote Login)"
    echo "  2. SSH key is set up or password authentication is enabled"
    echo "  3. iMac is reachable on the network"
    echo "  4. Correct hostname/IP and username in .env file"
    exit 1
fi

print_success "SSH connection established"

# Create service directories if they don't exist
print_status "📁 Ensuring service directories exist..."
ssh "$IMAC_USER@$IMAC_HOST" "mkdir -p $IMAC_PSALM_SERVICE_DIR $IMAC_LATIN_SERVICE_DIR"

# Copy files to their specific service directories
print_status "📤 Copying files to iMac service directories..."

# Copy psalms.json to PsalmService directory
print_status "Copying psalms.json to PsalmService..."
if scp "psalms.json" "$IMAC_USER@$IMAC_HOST:$IMAC_PSALM_SERVICE_DIR/"; then
    print_success "Copied psalms.json to PsalmService"
else
    print_error "Failed to copy psalms.json"
    exit 1
fi

# Copy themes.json to LatinService directory
print_status "Copying themes.json to LatinService..."
if scp "themes.json" "$IMAC_USER@$IMAC_HOST:$IMAC_LATIN_SERVICE_DIR/"; then
    print_success "Copied themes.json to LatinService"
else
    print_error "Failed to copy themes.json"
    exit 1
fi

print_success "🎉 All files copied to iMac!"
print_status "Files copied to service directories:"
print_status "  psalms.json → $IMAC_PSALM_SERVICE_DIR"
print_status "  themes.json → $IMAC_LATIN_SERVICE_DIR"
print_status "Next: Run build on iMac"