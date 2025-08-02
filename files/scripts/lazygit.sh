#!/bin/bash
#
# Non-interactive script to download and install the latest x86_64
# release of lazygit to /usr/local/bin.

set -e

# --- Configuration ---
REPO="jesseduffield/lazygit"
INSTALL_DIR="/usr/bin"
ARCH_PATTERN="Linux_x86_64"

# --- Dependency Check ---
if ! command -v curl &>/dev/null || ! command -v jq &>/dev/null; then
  echo "Error: This script requires 'curl' and 'jq' to be installed." >&2
  exit 1
fi

# --- Main Logic ---
API_URL="https://api.github.com/repos/$REPO/releases/latest"

DOWNLOAD_URL=$(curl -s "$API_URL" | jq -r ".assets[] | select(.name | test(\"$ARCH_PATTERN\"; \"i\") and test(\".tar.gz$\"; \"i\")) | .browser_download_url")

if [ -z "$DOWNLOAD_URL" ]; then
  echo "Error: Could not find a download URL for the $ARCH_PATTERN architecture." >&2
  exit 1
fi

TMP_DIR=$(mktemp -d)

curl -sL "$DOWNLOAD_URL" | tar -C "$TMP_DIR" -xz

sudo install "$TMP_DIR/lazygit" "$INSTALL_DIR"

rm -rf "$TMP_DIR"

echo "lazygit has been installed to $INSTALL_DIR"
