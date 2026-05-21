#!/bin/bash

# Function that processes the incoming clipboard text
process_clipboard() {
    # Read the clipboard content from standard input
    clipboard_content=$(cat)

    # Check if the clipboard text contains the Waystone item class
    if echo "$clipboard_content" | grep -q "Item Class: Waystones"; then
        # Extract the Name (Line 3) and Tier (Line 4)
        # We use 'tr -d "\r"' to remove Windows-style carriage returns that PoE often copies
        item_name=$(echo "$clipboard_content" | sed -n '3p' | tr -d '\r')
        item_tier=$(echo "$clipboard_content" | sed -n '4p' | tr -d '\r')

        # Trigger a desktop notification
        notify-send "Waystone Copied!" "$item_name\n$item_tier" \
            --icon=dialog-information \
            --app-name="PoE Clipboard Watcher"
    fi
}

# Export the function so it can be used by the subshell spawned by wl-paste
export -f process_clipboard

echo "Watching clipboard for Waystones... (Press Ctrl+C to stop)"

# Start watching the clipboard. Every time it updates, it runs our bash function.
wl-paste --watch bash -c process_clipboard
