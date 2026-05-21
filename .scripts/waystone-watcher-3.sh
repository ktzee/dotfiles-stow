#!/bin/bash

# Store the regex passed as the first argument and export it for the subshell
export WATCHER_REGEX="$1"

process_clipboard() {
    clipboard_content=$(cat)

    if echo "$clipboard_content" | grep -q "Item Class: Waystones"; then
        
        item_name=$(echo "$clipboard_content" | sed -n '3p' | tr -d '\r')
        item_tier=$(echo "$clipboard_content" | sed -n '4p' | tr -d '\r')

        notification_body="$item_name\n$item_tier"

        if [[ -n "$WATCHER_REGEX" ]]; then
            matching_lines=$(echo "$clipboard_content" | grep -E "$WATCHER_REGEX" | tr -d '\r')
            
            if [[ -n "$matching_lines" ]]; then
                highlighted=$(echo "$matching_lines" | sed 's/.*/<span color="#ff5555"><b>&<\/b><\/span>/')
                notification_body="$notification_body\n\n<b>Matched Mods:</b>\n$highlighted"
            fi
        fi

        # Kill any existing overlay so they don't stack if you copy rapidly
        pkill -f "waystone-overlay"

        # Spawn the YAD overlay window
        yad --title="waystone-overlay" \
            --text="<span font='12'><b>Waystone Copied!</b>\n\n$notification_body</span>" \
            --undecorated \
            --no-buttons \
            --on-top \
            --skip-taskbar \
            --borders=15 \
            --timeout=3 &
    fi
}

export -f process_clipboard

echo "Watching clipboard for Waystones..."
if [[ -n "$WATCHER_REGEX" ]]; then
    echo "Highlighting lines matching regex: $WATCHER_REGEX"
fi
echo "(Press Ctrl+C to stop)"

wl-paste --watch bash -c process_clipboard
