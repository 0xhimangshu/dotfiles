#!/usr/bin/env sh

#// Check if wlogout is already running
if pgrep -x "wlogout" > /dev/null
then
    pkill -x "wlogout"
    exit 0
fi

#// set file variables
scrDir=`dirname "$(realpath "$0")"`
source $scrDir/globalcontrol.sh
wLayout="${confDir}/wlogout/layout_1"
wlTmplt="${confDir}/wlogout/style_1.css"

#// detect monitor res
x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
hypr_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')

#// set default layout values
wlColms=6
export mgn=$(( y_mon * 28 / hypr_scale ))
export hvr=$(( y_mon * 23 / hypr_scale ))

#// scale font size
export fntSize=$(( y_mon * 2 / 100 ))

#// detect wallpaper brightness
[ -f "${cacheDir}/wall.dcol" ] && source "${cacheDir}/wall.dcol"
#  Theme mode: detects the color-scheme set in hypr.theme and falls back if nothing is parsed.
if [ "${enableWallDcol}" -eq 0 ]; then
    colorScheme="$({ grep -q "^[[:space:]]*\$COLOR[-_]SCHEME\s*=" "${themeDir}/hypr.theme" && grep "^[[:space:]]*\$COLOR[-_]SCHEME\s*=" "${themeDir}/hypr.theme" | cut -d '=' -f2 | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' ;} || 
                        grep 'gsettings set org.gnome.desktop.interface color-scheme' "${themeDir}/hypr.theme" | awk -F "'" '{print $((NF - 1))}')"
    colorScheme=${colorScheme:-$(gsettings get org.gnome.desktop.interface color-scheme)} 
    # should be declared explicitly so we can easily debug
    grep -q "dark" <<< "${colorScheme}" && dcol_mode="dark"
    grep -q "light" <<< "${colorScheme}" && dcol_mode="light"
[ -f "${themeDir}/theme.dcol" ] && source "${themeDir}/theme.dcol"
fi
[ "${dcol_mode}" == "dark" ] && export BtnCol="white" || export BtnCol="black"

#// eval hypr border radius
export active_rad=$(( hypr_border * 5 ))
export button_rad=$(( hypr_border * 8 ))

#// eval config files
wlStyle="$(envsubst < $wlTmplt)"

#// launch wlogout
wlogout -b "${wlColms}" -c 0 -r 0 -m 0 --layout "${wLayout}" --css <(echo "${wlStyle}") --protocol layer-shell
