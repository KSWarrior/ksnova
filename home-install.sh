#!/bin/bash

mkdir -p /usr/local/bin
if curl -fsSL "https://github.com/KSWarrior/ksnova/releases/latest/download/ksnova-linux" -o "/usr/local/bin/ksn"; then
    chmod +x "/usr/local/bin/ksn"
    echo "✅ KS Nova installed successfully!"
    echo "👤 Author: KS Warrior"
    echo "🌐 More info: https://github.com/KSWarrior/ksnova"
    echo "🚀 You can now run 'ksn' from anywhere."
else
    echo "❌ Failed to download KS Nova."
    echo "🔗 Visit the official site for manual installation: https://github.com/KSWarrior/ksnova"
    exit 1
fi
