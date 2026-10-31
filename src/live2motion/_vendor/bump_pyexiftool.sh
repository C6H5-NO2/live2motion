#!/bin/sh

COMMIT_HASH="e54f96cd75758096f72bc97c42390f1f9fef8010"

FILES=(
    "COPYING.BSD"
    "LICENSE"
    "README.rst"
    "exiftool/__init__.py"
    "exiftool/constants.py"
    "exiftool/exceptions.py"
    "exiftool/exiftool.py"
    "exiftool/experimental.py"
    "exiftool/helper.py"
)

set -euo pipefail

REPO_URL="https://github.com/sylikc/pyexiftool.git"

DST_DIR="$(dirname "$(realpath "$0")")/exiftool"

rm -rf "$DST_DIR"
mkdir -p "$DST_DIR"

TEMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TEMP_DIR"' EXIT

git init -q "$TEMP_DIR"
git -C "$TEMP_DIR" remote add origin "$REPO_URL"
git -C "$TEMP_DIR" fetch --depth 1 origin "$COMMIT_HASH"

# flatten
for file in "${FILES[@]}"; do
    git -C "$TEMP_DIR" show "$COMMIT_HASH:$file" > "$DST_DIR/$(basename "$file")"
done
