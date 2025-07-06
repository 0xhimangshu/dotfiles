#!/usr/bin/env python3

import subprocess
import json
import sys


def get_playerctl_output(command):
    try:
        return (
            subprocess.check_output(command, stderr=subprocess.DEVNULL).decode().strip()
        )
    except subprocess.CalledProcessError:
        return None


status = get_playerctl_output(["playerctl", "status"])

if status in ["Playing", "Paused"]:
    artist = get_playerctl_output(["playerctl", "metadata", "artist"])
    title = get_playerctl_output(["playerctl", "metadata", "title"])

    if not artist or not title:
        sys.exit(1)

    icon = "󰎆" if status == "Playing" else "▶"

    output = {
        "text": f"{icon} {title} - {artist}",
        "tooltip": f"Status: {status}\n{title} by {artist}",
        "class": f"mpris-{status}",
    }

    print(json.dumps(output))
else:
    sys.exit(1)
