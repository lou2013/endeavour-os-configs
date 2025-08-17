#!/bin/bash

PROFILE_FILE="/tmp/cpupower_profile"

if [ ! -f "$PROFILE_FILE" ]; then
    echo "Unknown"
    exit 1
fi

MODE=$(cat "$PROFILE_FILE")

# Optional: Pretty symbols/icons (you can customize these)
case "$MODE" in
    performance)
        ICON="🔥"
        ;;
    balanced)
        ICON="⚖️"
        ;;
    battery)
        ICON="🔋"
        ;;
    *)
        ICON="❓"
        ;;
esac

echo "$ICON $MODE"
