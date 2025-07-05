#!/usr/bin/env python3

import os
import subprocess
import time
import sys
import math
from collections import deque

NUM_BARS = 14
MIN_LEVEL = 1

BLOCKS = [
    "⠀",
    "░",
    "▒",
    "▓",
    "▁",
    "▂",
    "▃",
    "▄",
    "▅",
    "▆",
    "▇",
    "█",
]

WAVE_BLOCKS = ["⠀", "·", "∘", "○", "●", "◐", "◑", "◒", "◓", "◔", "◕", "⬤"]

BRAILLE_BLOCKS = ["⠀", "⠁", "⠃", "⠇", "⠏", "⠟", "⠿", "⡿", "⣿"]

CAVA_FIFO = "/tmp/cava.fifo"
CAVA_CONFIG = os.path.expanduser("~/.config/cava/config")
CAVA_DIR = os.path.dirname(CAVA_CONFIG)


class SmoothVisualizer:
    def __init__(self, bars=NUM_BARS, smoothing_factor=0.7, wave_amplitude=1.5):
        self.bars = bars
        self.smoothing_factor = smoothing_factor
        self.wave_amplitude = wave_amplitude
        self.history = deque(maxlen=5)
        self.smooth_levels = [0.0] * bars
        self.velocity = [0.0] * bars
        self.time_offset = 0.0

    def exponential_smooth(self, current, new_value, factor=None):
        """Exponential smoothing with configurable factor"""
        if factor is None:
            factor = self.smoothing_factor
        return current * factor + new_value * (1 - factor)

    def physics_smooth(self, index, target_value):
        """Physics-based smoothing with momentum"""
        current = self.smooth_levels[index]
        diff = target_value - current

        force = diff * 0.3
        self.velocity[index] = self.velocity[index] * 0.8 + force

        new_value = current + self.velocity[index]
        return max(0, min(len(BLOCKS) - 1, new_value))

    def gaussian_smooth(self, values, sigma=1.0):
        """Apply Gaussian smoothing to the values"""
        if len(values) < 3:
            return values

        smoothed = values.copy()
        for i in range(1, len(values) - 1):
            smoothed[i] = values[i - 1] * 0.25 + values[i] * 0.5 + values[i + 1] * 0.25
        return smoothed

    def apply_wave_modulation(self, values):
        """Apply smooth wave modulation"""
        self.time_offset += 0.1
        wave_values = []

        for i, val in enumerate(values):
            wave1 = math.sin(self.time_offset + i * math.pi / 6) * self.wave_amplitude
            wave2 = math.sin(self.time_offset * 1.3 + i * math.pi / 4) * (
                self.wave_amplitude * 0.5
            )
            wave3 = math.sin(self.time_offset * 0.7 + i * math.pi / 8) * (
                self.wave_amplitude * 0.3
            )

            combined_wave = wave1 + wave2 + wave3
            new_val = max(0, min(len(BLOCKS) - 1, val + combined_wave))
            wave_values.append(new_val)

        return wave_values

    def process_frame(self, raw_values):
        """Process a frame of audio data"""
        if not raw_values:
            for i in range(self.bars):
                self.smooth_levels[i] = self.physics_smooth(i, 0)
            return self.smooth_levels

        values = raw_values[: self.bars] + [0] * max(0, self.bars - len(raw_values))

        values = self.gaussian_smooth(values)

        values = self.apply_wave_modulation(values)

        self.history.append(values)

        if len(self.history) >= 2:
            for i in range(self.bars):
                current = values[i] if i < len(values) else 0
                historical_avg = sum(
                    frame[i] if i < len(frame) else 0
                    for frame in list(self.history)[-3:]
                ) / min(3, len(self.history))
                blended = self.exponential_smooth(historical_avg, current, 0.6)
                values[i] = blended

        for i in range(self.bars):
            target = values[i] if i < len(values) else 0
            self.smooth_levels[i] = self.physics_smooth(i, target)

        return self.smooth_levels

    def render(self, levels, style="blocks"):
        """Render the visualization"""
        if style == "blocks":
            blocks = BLOCKS
        elif style == "wave":
            blocks = WAVE_BLOCKS
        elif style == "braille":
            blocks = BRAILLE_BLOCKS
        else:
            blocks = BLOCKS

        output = ""
        for level in levels:
            index = int(min(max(level, 0), len(blocks) - 1))
            output += blocks[index]

        return output


def start_cava():
    """Start cava process if not already running"""
    if not any("cava" in p for p in subprocess.getoutput("pgrep -a cava").splitlines()):
        with open(CAVA_CONFIG, "w") as f:
            f.write(
                f"""
[general]
bars = {NUM_BARS}
sensitivity = 100
[input]
method = pulse
source = auto
[output]
method = raw
raw_target = {CAVA_FIFO}
data_format = ascii
ascii_max_range = 11
[smoothing]
integral = 64
monstercat = 1
waves = 1
gravity = 100
ignore = 0
"""
            )
        subprocess.Popen(
            ["cava", "-p", CAVA_CONFIG],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )


def setup_fifo():
    """Setup FIFO pipe for cava communication"""
    if os.path.exists(CAVA_FIFO) and not os.path.isfile(CAVA_FIFO):
        os.remove(CAVA_FIFO)
    if not os.path.exists(CAVA_FIFO):
        os.mkfifo(CAVA_FIFO)


def main():
    """Main application loop"""
    style = "blocks"
    if len(sys.argv) > 1:
        if sys.argv[1] in ["blocks", "wave", "braille"]:
            style = sys.argv[1]

    os.makedirs(CAVA_DIR, exist_ok=True)

    setup_fifo()

    time.sleep(0.5)

    start_cava()

    time.sleep(1)

    visualizer = SmoothVisualizer(
        bars=NUM_BARS, smoothing_factor=0.75, wave_amplitude=1.2
    )

    try:
        fifo_attempts = 0
        max_attempts = 10

        while fifo_attempts < max_attempts:
            try:
                with open(CAVA_FIFO, "r", buffering=1) as fifo:
                    while True:
                        try:
                            try:
                                status = (
                                    subprocess.check_output(["playerctl", "status"])
                                    .decode()
                                    .strip()
                                )
                                if status != "Playing":
                                    print(
                                        '{"text": "⠀", "class": "paused"}', flush=True
                                    )
                                    time.sleep(0.1)
                                    continue
                            except subprocess.CalledProcessError:
                                print('{"text": "⠀", "class": "paused"}', flush=True)
                                time.sleep(0.1)
                                continue

                            line = fifo.readline()
                            if not line:
                                print('{"text": "⠀", "class": "paused"}', flush=True)
                                time.sleep(0.05)
                                continue

                            line = line.strip()
                            if not line:
                                continue

                            raw_values = []
                            if ";" in line:
                                # Semicolon separated
                                parts = line.split(";")
                                for part in parts:
                                    if part.isdigit():
                                        raw_values.append(int(part))
                            else:
                                # Single digits
                                for char in line:
                                    if char.isdigit():
                                        raw_values.append(int(char))
                            levels = visualizer.process_frame(raw_values)

                            output = visualizer.render(levels, style)

                            json_output = output.replace('"', '\\"').replace(
                                "\\", "\\\\"
                            )
                            print(f'{{"text": "{json_output}"}}', flush=True)

                        except (BrokenPipeError, IOError) as e:
                            break
                        except Exception as e:
                            print('{"text": "⠀", "class": "paused"}', flush=True)
                            time.sleep(0.1)

                fifo_attempts += 1
                time.sleep(1)

            except FileNotFoundError:
                fifo_attempts += 1
                time.sleep(1)
                setup_fifo()
                start_cava()

        while True:
            print('{"text": "⠀."}', flush=True)
            time.sleep(1)

    except KeyboardInterrupt:
        pass
    except Exception as e:
        print('{"text": "⠀", "class": "paused"}', flush=True)


if __name__ == "__main__":
    main()
