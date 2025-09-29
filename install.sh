#!/usr/bin/env bash
# KS Nova Ultra-Fast Installer (wget-only, all methods, last-resort user path)

set -e

URL="https://raw.githubusercontent.com/KSWarrior/ksnova/refs/heads/main/ksnova-linux"
TMP_FILE="/tmp/ksnova-linux"
DEST="/usr/local/bin/ksnova-linux"
FALLBACK_DIR="$HOME/.local/bin"
USER_DEST="$HOME/ks_nova/local/bin/ksnova-linux"

echo "📥 Downloading KS Nova..."

if command -v wget &>/dev/null; then
    wget -qO "$TMP_FILE" "$URL" || { echo "❌ Download failed"; exit 1; }
else
    echo "❌ wget not found. Please install wget and try again."
    exit 1
fi

chmod +x "$TMP_FILE"

echo "📦 Installing KS Nova..."

try_methods() {
    local src="$1"
    local dst="$2"

    mv "$src" "$dst" 2>/dev/null && return 0
    command -v install &>/dev/null && install -m 755 "$src" "$dst" 2>/dev/null && return 0
    cp "$src" "$dst" 2>/dev/null && chmod +x "$dst" 2>/dev/null && return 0
    [ -d "$(dirname "$dst")" ] && ln -sf "$src" "$dst" 2>/dev/null && return 0

    return 1
}

# 1️⃣ Try without sudo (fast)
if try_methods "$TMP_FILE" "$DEST"; then
    echo "✅ KS Nova installed successfully to $DEST"
    exit 0
fi

# 2️⃣ Try with sudo if available
if command -v sudo &>/dev/null; then
    if sudo bash -c "$(declare -f try_methods); try_methods '$TMP_FILE' '$DEST'"; then
        echo "✅ KS Nova installed successfully (with sudo) to $DEST"
        exit 0
    fi
fi

# 3️⃣ Fallback to ~/.local/bin
mkdir -p "$FALLBACK_DIR"
FALLBACK_DEST="$FALLBACK_DIR/$(basename "$DEST")"
if cp "$TMP_FILE" "$FALLBACK_DEST" 2>/dev/null && chmod +x "$FALLBACK_DEST"; then
    [[ ":$PATH:" != *":$FALLBACK_DIR:"* ]] && echo "⚠️ Add this to your shell profile to use 'ksnova-linux' easily:"
    [[ ":$PATH:" != *":$FALLBACK_DIR:"* ]] && echo "   export PATH=\"$FALLBACK_DIR:\$PATH\""
    echo "✅ KS Nova installed locally to $FALLBACK_DEST"
    exit 0
fi

# 4️⃣ Last-resort user-only path
mkdir -p "$(dirname "$USER_DEST")"
if cp "$TMP_FILE" "$USER_DEST" && chmod +x "$USER_DEST"; then
    echo "✅ KS Nova installed successfully to $USER_DEST"
    echo "💡 Run it with full path:"
    echo "   $USER_DEST"
    echo "   or relative:"
    echo "   ./ks_nova/local/bin/ksnova-linux"
    exit 0
fi

# 5️⃣ Final failure
echo "❌ Installation failed after all attempts."
exit 1
