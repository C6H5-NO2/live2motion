#!/bin/sh

COMMIT_HASH="ff46699215f1071ada579140d73994a4be29a399"

FILES=(
    "LICENSE"
    "Muxer.py"
    "README.md"
    "SamsungTags.py"
    "constants.py"
    "utils.py"
)

set -euo pipefail

REPO_URL="https://github.com/PetrVys/MotionPhoto2.git"

DST_DIR="$(dirname "$(realpath "$0")")/motionphoto2"

rm -rf "$DST_DIR"
mkdir -p "$DST_DIR"

TEMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TEMP_DIR"' EXIT

git init -q "$TEMP_DIR"
git -C "$TEMP_DIR" remote add origin "$REPO_URL"
git -C "$TEMP_DIR" fetch --depth 1 origin "$COMMIT_HASH"

git -C "$TEMP_DIR" archive "$COMMIT_HASH" "${FILES[@]}" | tar -x -C "$DST_DIR"

# fix imports
sed -i \
    -e 's/from utils import/from .utils import/' \
    -e 's/import constants/from . import constants/' \
    -e 's/from SamsungTags import/from .SamsungTags import/' \
    "$DST_DIR/Muxer.py"
sed -i -e 's/import constants/from . import constants/' "$DST_DIR/SamsungTags.py"
sed -i -e 's/import constants/from . import constants/' "$DST_DIR/utils.py"

echo "bumped motionphoto2 to $COMMIT_HASH in $DST_DIR"
