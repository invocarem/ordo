#!/bin/bash
set -e

# Simple script to copy production files to iMac via Tailscale Taildrop
# Copies psalms.json and themes.json to iMac Downloads folder

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
IMAC_DEVICE_NAME=${IMAC_DEVICE_NAME:-"chens-imac"}

print_status "🚀 Copying production files to iMac via Taildrop..."

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

# Check if Tailscale is available
if ! command -v tailscale &> /dev/null; then
    print_error "Tailscale command not found"
    print_status "Please install Tailscale: https://tailscale.com/download"
    exit 1
fi

# Test connection to iMac
print_status "🔌 Testing connection to $IMAC_DEVICE_NAME..."
if ! tailscale ping $IMAC_DEVICE_NAME > /dev/null 2>&1; then
    print_error "Cannot reach iMac"
    print_status "Please ensure Tailscale is running on both machines"
    exit 1
fi

# Copy files using Taildrop
print_status "📤 Sending files to iMac Downloads folder..."

for file in "${REQUIRED_FILES[@]}"; do
    print_status "Sending $file..."
    if tailscale file cp "$file" "$IMAC_DEVICE_NAME:"; then
        print_success "Sent $file"
    else
        print_error "Failed to send $file"
        exit 1
    fi
done

print_success "🎉 All files sent to iMac Downloads folder!"
print_status "Files: psalms.json, themes.json"
print_status "Next: Move files to project directory and run build on iMac"