#!/usr/bin/env bash
# KS Nova Ultra-Fast Installer (user-only, wget-only, no root)

set -e

KS_DIR="$HOME/ksnova"
BIN_DIR="$KS_DIR/bin"
TMP_FILE="$KS_DIR/ksnova-linux"
DEST="$BIN_DIR/ksnova-linux"

mkdir -p "$BIN_DIR"

URL="https://raw.githubusercontent.com/KSWarrior/ksnova/refs/heads/main/ksnova-linux"

echo "📥 Downloading KS Nova..."

if command -v wget &>/dev/null; then
    wget -qO "$TMP_FILE" "$URL" || { echo "❌ Download failed"; exit 1; }
else
    echo "❌ wget not found. Please install wget and try again."
    exit 1
fi

chmod +x "$TMP_FILE"
mv "$TMP_FILE" "$DEST"

echo "✅ KS Nova installed successfully to $DEST"

# Add to PATH if not already
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo "⚠️ Add this line to your shell profile (~/.bashrc or ~/.zshrc) to use 'ksnova-linux' easily:"
    echo "   export PATH=\"$BIN_DIR:\$PATH\""
fi

echo "💡 Run KS Nova with:"
echo "   $DEST"
echo "   or after adding to PATH:"
echo "   ksnova-linux"
