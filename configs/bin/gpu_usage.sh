#!/bin/bash

gpu_found=false

# Check all hwmon devices
for hwmon in /sys/class/hwmon/hwmon*; do
    [[ ! -f "$hwmon/name" ]] && continue
    name=$(cat "$hwmon/name")

    case "$name" in
        amdgpu)
            # AMD GPU usage or temperature
            if [[ -f "$hwmon/device/gpu_busy_percent" ]]; then
                usage=$(cat "$hwmon/device/gpu_busy_percent")
                echo "${usage}%"
                gpu_found=true
                break
            elif [[ -f "$hwmon/temp1_input" ]]; then
                temp=$(($(cat "$hwmon/temp1_input") / 1000))
                echo "${temp}°C"
                gpu_found=true
                break
            fi
            ;;
        i915)
            # Intel iGPU temperature
            if [[ -f "$hwmon/temp1_input" ]]; then
                temp=$(($(cat "$hwmon/temp1_input") / 1000))
                echo "${temp}°C"
                gpu_found=true
                break
            fi
            ;;
    esac
done

# If no GPU was found, show "GPU: N/A"
if ! $gpu_found; then
    echo "N/A"
fi
