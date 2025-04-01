#!/usr/bin/env sh

# Set paths
scrDir="$(dirname "$(realpath "$0")")"
source "${scrDir}/globalcontrol.sh"
theme="${confDir}/rofi/emoji.rasi"

# Get cursor position
readarray -t curPos < <(hyprctl cursorpos -j | jq -r '.x,.y')
readarray -t monRes < <(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width,.height,.scale,.x,.y')
readarray -t offRes < <(hyprctl -j monitors | jq -r '.[] | select(.focused==true).reserved | map(tostring) | join("\n")')

monRes[2]="$(echo "${monRes[2]}" | sed "s/\.//")"
monRes[0]="$(( ${monRes[0]} * 100 / ${monRes[2]} ))"
monRes[1]="$(( ${monRes[1]} * 100 / ${monRes[2]} ))"
curPos[0]="$(( ${curPos[0]} - ${monRes[3]} ))"
curPos[1]="$(( ${curPos[1]} - ${monRes[4]} ))"

if [ "${curPos[0]}" -ge "$((${monRes[0]} / 2))" ] ; then
    x_pos="east"
    x_off="-$(( ${monRes[0]} - ${curPos[0]} - ${offRes[2]} ))"
else
    x_pos="west"
    x_off="$(( ${curPos[0]} - ${offRes[0]} ))"
fi

if [ "${curPos[1]}" -ge "$((${monRes[1]} / 2))" ] ; then
    y_pos="south"
    y_off="-$(( ${monRes[1]} - ${curPos[1]} - ${offRes[3]} ))"
else
    y_pos="north"
    y_off="$(( ${curPos[1]} - ${offRes[1]} ))"
fi

r_override="window{location:${x_pos} ${y_pos};anchor:${x_pos} ${y_pos};x-offset:${x_off}px;y-offset:${y_off}px;width:18em;height:18em;} "


# Function to load only emojis from JSON
# get_emojis() {
#     jq -r '.[].emoji' "${scrDir}/emoji.json"
# }

get_emojis() {
    jq -r '.[] | "\(.emoji) \(.description) (\(.aliases | join(", ")))"' "${scrDir}/emoji.json"
}
# Rofi Emoji Picker (6x6 Grid, No Names)
chosen=$(get_emojis | rofi -dmenu -i -theme "$theme" -p "Pick an emoji" -theme-str "${r_override}")

# Copy selected emoji to clipboard
if [ -n "$chosen" ]; then
    echo -n "$chosen" | wl-copy
    notify-send "Copied: $chosen"
fi
