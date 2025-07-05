#!/bin/bash

# Debug output
echo "Current mode: $(~/.config/waybar/scripts/tlp-status.sh)"

CURRENT=$(~/.config/waybar/scripts/tlp-status.sh)

case "$CURRENT" in
  "Perf")
    echo "Switching to Max profile"
    tlp-profile performance ;;
  "Balanced")
    echo "Switching to Cool profile"
    tlp-profile balanced ;;
  "Save")
    echo "Switching to Chill profile"
    tlp-profile powersave ;;
  *)
    echo "Switching to default profile"
    tlp-profile balanced ;;
esac

# Add a message when done
echo "TLP profile changed."
