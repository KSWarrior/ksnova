#!/bin/bash
echo "📥 Installing KS Nova by KS Warrior"
echo "🌐 Official site: https://github.com/KSWarrior/ksnova"
echo

mkdir -p "$HOME/.ksnova/bin"
echo "📂 Created directory: $HOME/.ksnova/bin"

if wget -q https://github.com/KSWarrior/ksnova/releases/latest/download/ksnova-linux -O "$HOME/.ksnova/bin/ksn"; then
    echo "✅ Downloaded KS Nova successfully!"
else
    echo "❌ Failed to download KS Nova. Visit https://github.com/KSWarrior/ksnova for manual installation."
    exit 1
fi

chmod +x "$HOME/.ksnova/bin/ksn"
echo "🔑 Made KS Nova executable."

# Add export to ~/.profile (guaranteed to load for login shells)
if ! grep -q ".ksnova/bin" "$HOME/.profile"; then
    echo 'export PATH="$HOME/.ksnova/bin:$PATH"' >> "$HOME/.profile"
    echo "➕ Added KS Nova to PATH in ~/.profile"
else
    echo "ℹ️ KS Nova path already exists in ~/.profile"
fi

# Ensure ~/.bash_profile sources ~/.profile (if it exists)
if [ ! -f "$HOME/.bash_profile" ] || ! grep -q ".profile" "$HOME/.bash_profile"; then
    echo '[ -f "$HOME/.profile" ] && . "$HOME/.profile"' >> "$HOME/.bash_profile"
    echo "🔗 Ensured ~/.bash_profile sources ~/.profile"
else
    echo "ℹ️ ~/.bash_profile already sources ~/.profile"
fi

# Apply immediately
export PATH="$HOME/.ksnova/bin:$PATH"

if command -v ksn >/dev/null 2>&1; then
    echo "✅ KS Nova installation successful!"
else
    echo "❌ Failed to download KS Nova."
    echo "🔗 Visit the official site for manual installation: https://github.com/KSWarrior/ksnova"
    exit 1
fi
