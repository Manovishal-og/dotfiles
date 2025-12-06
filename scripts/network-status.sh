
#!/bin/bash
ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
eth=$(nmcli -t -f DEVICE,STATE dev | grep ethernet | grep connected)

if [[ -n "$ssid" ]]; then
    echo "📶 $ssid"
elif [[ -n "$eth" ]]; then
    echo "🔌 Ethernet"
else
    echo "❌ Offline"
fi
