#!/usr/bin/env bash
# KS Nova Ultra-Fast Installer (All methods quickly, last-resort user path)

set -e

URL="https://raw.githubusercontent.com/KSWarrior/ksnova/refs/heads/main/ksnova-linux"
TMP_FILE="/tmp/ksnova-linux"
DEST="/usr/local/bin/ksnova-linux"
FALLBACK_DIR="$HOME/.local/bin"          # Normal fallback
USER_DEST="$HOME/ks_nova/local/bin/ksnova-linux"   # Last-resort path

echo "📥 Downloading KS Nova..."
curl -fsSL "$URL" -o "$TMP_FILE"
chmod +x "$TMP_FILE"

echo "📦 Installing KS Nova..."

try_methods() {
    local src="$1"
    local dst="$2"

    # Try mv
    mv "$src" "$dst" 2>/dev/null && return 0
    # Try install
    command -v install &>/dev/null && install -m 755 "$src" "$dst" 2>/dev/null && return 0
    # Try cp + chmod
    cp "$src" "$dst" 2>/dev/null && chmod +x "$dst" 2>/dev/null && return 0
    # Try symlink if dir exists
    [ -d "$(dirname "$dst")" ] && ln -sf "$src" "$dst" 2>/dev/null && return 0

    return 1
}

# 1️⃣ Fast try without sudo
if try_methods "$TMP_FILE" "$DEST"; then
    echo "✅ KS Nova installed successfully"
    exit 0
fi

# 2️⃣ Try with sudo if available
if command -v sudo &>/dev/null; then
    if sudo bash -c "$(declare -f try_methods); try_methods '$TMP_FILE' '$DEST'"; then
        echo "✅ KS Nova installed successfully (with sudo)"
        exit 0
    fi
fi

# 3️⃣ Try fallback to ~/.local/bin
mkdir -p "$FALLBACK_DIR"
FALLBACK_DEST="$FALLBACK_DIR/$(basename "$DEST")"
if cp "$TMP_FILE" "$FALLBACK_DEST" 2>/dev/null && chmod +x "$FALLBACK_DEST"; then
    [[ ":$PATH:" != *":$FALLBACK_DIR:"* ]] && echo "⚠️ Add $FALLBACK_DIR to PATH manually"
    echo "✅ KS Nova installed locally to $FALLBACK_DEST"
    exit 0
fi

# 4️⃣ Last-resort user-only path
mkdir -p "$(dirname "$USER_DEST")"
if cp "$TMP_FILE" "$USER_DEST" && chmod +x "$USER_DEST"; then
    echo "✅ KS Nova installed successfully to $USER_DEST"
    echo "⚠️ To run KS Nova, use the full path:"
    echo "   $USER_DEST"
    echo "   or relative:"
    echo "   ./ks_nova/local/bin/ksnova-linux"
    exit 0
fi

# 5️⃣ Final failure
echo "❌ Installation failed after all attempts."
exit 1
