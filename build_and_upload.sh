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

