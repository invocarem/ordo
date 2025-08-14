#!/bin/bash
# Universal test runner for macOS/Linux/Docker

set -e

# Configure logging
LOG_DIR="./.test_logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/$(date +%Y%m%d_%H%M%S).log"

# Run tests with filter (if provided)
if [ -n "$1" ]; then
    echo "🔍 Running filtered tests: $1"
    swift test --filter "$1" 2>&1 | tee "$LOG_FILE"
else
    echo "🔍 Running all tests"
    swift test 2>&1 | tee "$LOG_FILE"
fi

# Parse results
if grep -q "Test Suite.*failed" "$LOG_FILE"; then
    echo "❌ Tests failed!"
    exit 1
else
    echo "✅ All tests passed!"
    exit 0
fi
