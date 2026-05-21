#!/bin/bash

# Store the regex passed as the first argument and export it for the subshell
export WATCHER_REGEX="$1"

# Function that processes the incoming clipboard text
process_clipboard() {
    # Read the clipboard content from standard input
    clipboard_content=$(cat)

    # Check if the clipboard text contains the Waystone item class
    if echo "$clipboard_content" | grep -q "Item Class: Waystones"; then
        
        # Extract the Name (Line 3) and Tier (Line 4), stripping carriage returns
        item_name=$(echo "$clipboard_content" | sed -n '3p' | tr -d '\r')
        item_tier=$(echo "$clipboard_content" | sed -n '4p' | tr -d '\r')

        notification_body="$item_name\n$item_tier"

        # If a regex was provided, search for it in the clipboard text
        if [[ -n "$WATCHER_REGEX" ]]; then
            # Extract the matching lines (ignoring carriage returns)
            # We use grep -E to support extended regex (like | for OR)
            matching_lines=$(echo "$clipboard_content" | grep -E "$WATCHER_REGEX" | tr -d '\r')
            
            # If we found any matches, format them with HTML and append them
            if [[ -n "$matching_lines" ]]; then
                # Wrap each matched line in bold red text using sed
                highlighted=$(echo "$matching_lines" | sed 's/.*/<span color="#ff5555"><b>&<\/b><\/span>/')
                
                notification_body="$notification_body\n\n<b>Matched Mods:</b>\n$highlighted"
            fi
        fi

        # Trigger a desktop notification
        notify-send "Waystone Copied!" "$notification_body" \
            --icon=dialog-information \
            --app-name="PoE Clipboard Watcher"
    fi
}

# Export the function so it can be used by the subshell spawned by wl-paste
export -f process_clipboard

echo "Watching clipboard for Waystones..."
if [[ -n "$WATCHER_REGEX" ]]; then
    echo "Highlighting lines matching regex: $WATCHER_REGEX"
fi
echo "(Press Ctrl+C to stop)"

# Start watching the clipboard natively. Every time it updates, it runs our bash function.
wl-paste --watch bash -c process_clipboard
