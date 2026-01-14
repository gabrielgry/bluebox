#!/usr/bin/env bash
set -euo pipefail

command -v jq curl unzip dnf >/dev/null

RELEASES=$(curl -fLs https://api.github.com/repos/bitwarden/clients/releases?per_page=100)

DESKTOP_RPM_URL=$(jq -r '
    [.[]
      | .assets[]
      | select(.name | startswith("Bitwarden-") and endswith("-x86_64.rpm"))
    ] | max_by(.created_at | fromdate).browser_download_url
' <<<"$RELEASES")

CLI_LINUX_URL=$(jq -r '
    [.[]
      | .assets[]
      | select(.name | startswith("bw-linux-") and endswith(".zip"))
    ] | max_by(.created_at | fromdate).browser_download_url
' <<<"$RELEASES")

[[ -n "$DESKTOP_RPM_URL" ]] || { echo "Desktop RPM not found"; exit 1; }
[[ -n "$CLI_LINUX_URL" ]] || { echo "CLI zip not found"; exit 1; }

echo "Installing Bitwarden Desktop from: $DESKTOP_RPM_URL"
dnf install -y "$DESKTOP_RPM_URL"

echo "Installing Bitwarden CLI from: $CLI_LINUX_URL"
TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

ZIP_FILE="$TEMP_DIR/bw-linux.zip"
INSTALL_DIR="/usr/bin"

curl -fLs -o "$ZIP_FILE" "$CLI_LINUX_URL"
unzip -q "$ZIP_FILE" -d "$TEMP_DIR"

BW_BIN=$(find "$TEMP_DIR" -type f -name bw -perm -u+x | head -n1)
install -m 0755 "$BW_BIN" "$INSTALL_DIR/bw"
