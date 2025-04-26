#!/bin/bash

# Path to the .desktop file
DESKTOP_FILE="/usr/share/applications/signal-desktop.desktop"

# Use sed to update the Exec line
sed -i 's|^Exec=signal-desktop -- |Exec=signal-desktop --password-store="kwallet6" -- |' "$DESKTOP_FILE"
