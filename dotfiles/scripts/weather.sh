#!/bin/bash

# Configurable variables
CITY="Jorhat"   # Set your city here
UNIT="m"            # Use 'm' for metric, 'u' for US units, or leave empty for default
LANG="en"           # Set language for output (e.g., en, fr, de)

# Fetch weather info from wttr.in with additional details
WEATHER=$(curl -s "wttr.in/$CITY?format=%l:+%c+%t+%w+%h+%p&$UNIT&lang=$LANG")

# Handle curl errors
if [ $? -ne 0 ]; then
  echo '{"text": "Weather unavailable", "tooltip": "Failed to fetch weather data."}'
  exit 1
fi

# Output JSON for Waybar with a detailed tooltip
echo "{\"text\": \"$WEATHER\", \"tooltip\": \"Weather in $CITY (Unit: $UNIT)\"}"


