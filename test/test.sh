#!/bin/bash

# Colors for test output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Get absolute path to the depsentry script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEPSENTRY_BIN="$SCRIPT_DIR/../bin/depsentry"

# Test setup
TEST_DIR=$(mktemp -d)
cd "$TEST_DIR" || exit 1

echo "TEST_DIR: $TEST_DIR"
echo "Using depsentry from: $DEPSENTRY_BIN"

# Cleanup function
cleanup() {
    rm -rf "$TEST_DIR"
}
trap cleanup EXIT

# Test helper functions
assert() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ $1${NC}"
    else
        echo -e "${RED}✗ $1${NC}"
        exit 1
    fi
}

# Create test files
echo "test content" > test-file.txt
echo "package content" > package-lock.json

# Test 1: Init creates config file
"$DEPSENTRY_BIN" init
assert "Init creates configuration file" test -f .depsentry

# Test 2: Running without command should perform check and create state
"$DEPSENTRY_BIN"
assert "Default command (check) creates state file" test -f .depsentry-state

# Test 3: Check with unchanged files should pass
"$DEPSENTRY_BIN"
assert "Check passes with unchanged files"

# Test 4: Check should fail when file changes
echo "modified content" > package-lock.json
! "$DEPSENTRY_BIN"
assert "Check fails when file changes"

# Test 5: Update should update checksums
"$DEPSENTRY_BIN" update
"$DEPSENTRY_BIN"
assert "Update refreshes checksums"

echo "All tests passed! 🎉" 