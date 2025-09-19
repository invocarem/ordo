#!/bin/bash
set -e

BUILD_NUM=$(date +%Y%m%d%H%M)


if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

# Read credentials from environment variables (with fallback to empty)
APPLE_ID=${APPLE_ID:-"dashtotherock@gmail.com"}
APPLE_PASSWORD=${APPLE_PASSWORD:-""}

SCHEME="ordo"
ARCHIVE_PATH="./build/ordo.xcarchive"
EXPORT_PATH="./build/ordo"

# Check for newer files in Downloads folder
echo "🔍 Checking for newer files in Downloads folder..."

DOWNLOADS_DIR="$HOME/Downloads"
REQUIRED_FILES=("psalms.json" "themes.json")
FILES_UPDATED=false

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$DOWNLOADS_DIR/$file" ]; then
        # Determine target directory based on file type
        if [ "$file" = "psalms.json" ]; then
            TARGET_DIR="ordo/Services/PsalmService"
        elif [ "$file" = "themes.json" ]; then
            TARGET_DIR="ordo/Services/LatinService"
        else
            TARGET_DIR="."
        fi
        
        TARGET_FILE="$TARGET_DIR/$file"
        
        # Check if Downloads file is newer than target file
        if [ ! -f "$TARGET_FILE" ] || [ "$DOWNLOADS_DIR/$file" -nt "$TARGET_FILE" ]; then
            echo "📁 Found newer $file in Downloads, copying to $TARGET_DIR..."
            cp "$DOWNLOADS_DIR/$file" "$TARGET_FILE"
            FILES_UPDATED=true
        else
            echo "ℹ️  Current $file in $TARGET_DIR is up to date"
        fi
    else
        echo "ℹ️  No $file found in Downloads folder"
    fi
done

if [ "$FILES_UPDATED" = true ]; then
    echo "✅ Files updated from Downloads folder"
else
    echo "ℹ️  No newer files found in Downloads folder"
fi

echo "🚀 Cleaning old build..."
rm -rf build

echo "🏗 Archiving project..."
xcodebuild -project ordo.xcodeproj \
   -scheme ordo -configuration Release -destination "generic/platform=iOS" \
   archive \
   -archivePath ./build/ordo.xcarchive \
   SWIFT_OPTIMIZATION_LEVEL=-Onone \
   CODE_SIGN_STYLE=Manual \
   CODE_SIGN_IDENTITY="Apple Distribution: Chen Chen (RD9Q6XUA82)" \
   CURRENT_PROJECT_VERSION=$BUILD_NUM \
   PROVISIONING_PROFILE="9da726df-b079-4469-8096-5aa87cc8ae18" \
   INFOPLIST_FILE="ordo/Info.plist"


echo "📦 Exporting IPA..."
xcodebuild -exportArchive \
  -archivePath "$ARCHIVE_PATH" \
  -exportPath "$EXPORT_PATH" \
  -exportOptionsPlist "./ExportOptions.plist" \
  -allowProvisioningUpdates

IPA_PATH="$EXPORT_PATH/$SCHEME.ipa"

echo "☁️ Uploading to TestFlight..."
xcrun altool --upload-app \
  --type ios \
  --file "$IPA_PATH" \
  -u "$APPLE_ID" \
  -p "$APPLE_PASSWORD"

echo "✅ Build uploaded to TestFlight. Check App Store Connect."

