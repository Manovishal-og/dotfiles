
#!/bin/bash
status=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null)
capacity=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null)

if [[ -n "$status" && -n "$capacity" ]]; then
    icon="🔋"
    [[ "$status" == "Charging" ]] && icon="⚡"
    echo "$icon $capacity%"
else
    echo "🔌 AC Power"
fi
