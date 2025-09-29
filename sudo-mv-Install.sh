#!/usr/bin/env bash
set -e

echo "📥 Downloading KS Nova..."

# Download the executable
if wget -q https://raw.githubusercontent.com/KSWarrior/ksnova/refs/heads/main/ksnova-linux -O ksnova-linux; then
    echo "✅ Download completed!"
else
    echo "❌ Failed to download KS Nova!"
    echo " Visit https://github.com/KSWarrior/ksnova for installation."
    exit 1
fi

# Make it executable
chmod +x ksnova-linux

# Try installing to /usr/local/bin
if sudo mkdir -p /usr/local/bin && sudo mv ksnova-linux /usr/local/bin/ksn; then
    echo "✅ KS Nova installed successfully in /usr/local/bin!"
    echo "You can now run it using: ksn"
else
    echo "⚠️ Could not install to /usr/local/bin. Trying alternative method..."
    
    # Alternative: install to user home directory
    USER_DIR="$HOME/.ksnova/bin"
    mkdir -p "$USER_DIR"
    
    if mv ksnova-linux "$USER_DIR/ksn"; then
        echo "✅ KS Nova installed successfully in $USER_DIR!"
        echo "Add this to your PATH to run it anywhere:"
        echo "  export PATH=\"\$HOME/.ksnova/bin:\$PATH\""
        echo "You can now run it using: ksn"
    else
        echo "❌ Installation failed! Please check your permissions or visit:"
        echo "   https://github.com/KSWarrior/ksnova for manual installation instructions."
        exit 1
    fi
fi
