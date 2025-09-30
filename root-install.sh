#!/bin/bash

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "❌ This installer must be run as root (or with sudo)."
    echo "💡 Try: sudo bash install-ksnova.sh"
    exit 1
fi

mkdir -p /usr/local/bin
if curl -fsSL "https://github.com/KSWarrior/ksnova/releases/latest/download/ksnova-linux" -o "/usr/local/bin/ksn"; then
    chmod +x "/usr/local/bin/ksn"
    echo "✅ KS Nova download successfully!"
    echo "👤 Author: KS Warrior"
    echo "🌐 More info: https://github.com/KSWarrior/ksnova"
    echo "🚀 You can now run 'ksn' from anywhere."
else
    echo "❌ Failed to download KS Nova."
    echo "🔗 Visit the official site for manual installation: https://github.com/KSWarrior/ksnova"
    exit 1
fi

if command -v ksn >/dev/null 2>&1; then
    echo "✅ KS Nova installation successful!"
else
    echo "❌ Failed to download KS Nova."
    echo "🔗 Visit the official site for manual installation: https://github.com/KSWarrior/ksnova"
    exit 1
fi
