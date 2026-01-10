#!/usr/bin/env bash
set -euo pipefail

echo "Configure Display Manager"

# Enable cosmic-greeter (COSMIC's display manager)
systemctl disable gdm
systemctl enable cosmic-greeter

# Set COSMIC as default session
mkdir -p /etc/X11/sessions
cat > /etc/X11/sessions/cosmic.desktop << 'COSMICDESKTOP'
[Desktop Entry]
Name=COSMIC
Comment=COSMIC Desktop Environment
Exec=cosmic-session
Type=Application
DesktopNames=COSMIC
COSMICDESKTOP

echo "Display manager configured"