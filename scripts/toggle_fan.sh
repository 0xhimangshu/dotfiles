
#!/bin/bash

file="/sys/devices/platform/asus-nb-wmi/hwmon/hwmon*/pwm1_enable"

# Read the current value
current_value=$(cat $file)

if [[ "$current_value" -eq 0 ]]; then
    pkexec bash -c "echo 2 > $file"
else
    pkexec bash -c "echo 0 > $file"
fi
