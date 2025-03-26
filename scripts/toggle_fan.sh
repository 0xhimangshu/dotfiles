#!/bin/bash

file="/sys/devices/platform/asus-nb-wmi/hwmon/hwmon*/pwm1_enable"

# Read the current value
current_value=$(cat $file)

if [[ "$current_value" -eq 0 ]]; then
    echo 2 | sudo bash -c "tee $file"
else
    echo 0 | sudo bash -c "tee $file"
fi

