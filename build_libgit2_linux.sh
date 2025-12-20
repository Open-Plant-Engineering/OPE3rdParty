#!/usr/bin/env bash
set -e

# ============================
#   FOLDER STRUCTURE
# ============================
ROOT_DIR="$PWD"
DOWNLOAD_DIR="$ROOT_DIR/Download"
INSTALL_DIR="$ROOT_DIR/Install/libgit2"
REPO_DIR="$DOWNLOAD_DIR/libgit2"
BUILD_DIR="$DOWNLOAD_DIR/build-linux"

# ============================
#   CHECK REQUIRED TOOLS
# ============================
for tool in git cmake gcc g++; do
    if ! command -v $tool >/dev/null 2>&1; then
        echo "Error: $tool is not installed"
        exit 1
    fi
done

# ============================
#   CREATE FOLDERS
# ============================
mkdir -p "$DOWNLOAD_DIR"
mkdir -p "$INSTALL_DIR"

# ============================
#   CLONE OR UPDATE REPO
# ============================
if [ ! -d "$REPO_DIR" ]; then
    echo "Cloning libgit2..."
    git clone --recursive https://github.com/libgit2/libgit2.git "$REPO_DIR"
else
    echo "Updating libgit2..."
    cd "$REPO_DIR"
    git pull
    git submodule update --init --recursive
    cd "$ROOT_DIR"
fi

# ============================
#   CREATE BUILD DIR
# ============================
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# ============================
#   CONFIGURE WITH CMAKE
# ============================
cmake "$REPO_DIR" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$INSTALL_DIR" \
    -DBUILD_SHARED_LIBS=ON \
    -DUSE_SSH=OFF \
    -DUSE_HTTPS=ON

# ============================
#   BUILD
# ============================
cmake --build . -- -j"$(nproc)"

# ============================
#   INSTALL
# ============================
cmake --install .

echo
echo "=========================================="
echo "libgit2 built and installed successfully!"
echo "Installed to:"
echo "  $INSTALL_DIR"
echo "=========================================="
echo