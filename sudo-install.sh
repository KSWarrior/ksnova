#!/usr/bin/env bash
set -euo pipefail

# -------------------------------
# KS Nova Installer
# Created by KS Warrior
# -------------------------------

URL="https://raw.githubusercontent.com/KSWarrior/ksnova/refs/heads/main/ksnova-linux"
DEFAULT_DIR="/usr/local/bin/ksn"
NON_ROOT_DIR="$HOME/.local/bin"
FILE_NAME="ksn"
OFFICIAL_SITE="https://github.com/KSWarrior/ksnova"
AUTHOR="KS Warrior"

# -------------------------------
# Function: Error handler
# -------------------------------
error_exit() {
    echo -e "\n❌ An error occurred during installation."
    echo "KS Nova is created by $AUTHOR."
    echo "Please visit the official KS Nova site for manual installation:"
    echo "$OFFICIAL_SITE"
    exit 1
}

# -------------------------------
# Function: Ensure wget exists
# -------------------------------
check_dependencies() {
    command -v wget >/dev/null 2>&1 || { 
        echo "❌ wget is required but not installed."
        echo "KS Nova is created by $AUTHOR."
        error_exit
    }
}

# -------------------------------
# Function: Choose target directory
# -------------------------------
select_target_dir() {
    TARGET_DIR="$DEFAULT_DIR"
    if [ ! -w "$(dirname "$TARGET_DIR")" ]; then
        echo "⚠️ Cannot write to $DEFAULT_DIR. Using non-root directory instead..."
        TARGET_DIR="$NON_ROOT_DIR"
        mkdir -p "$TARGET_DIR" || error_exit
        echo "✅ Directory created: $TARGET_DIR"
        echo '📌 Make sure this directory is in your PATH:'
        echo "export PATH=\"$NON_ROOT_DIR:\$PATH\""
        echo "You can add it to ~/.bashrc or ~/.zshrc"
    else
        sudo mkdir -p "$TARGET_DIR" || error_exit
        echo "✅ Directory created: $TARGET_DIR"
    fi
}

# -------------------------------
# Function: Download KS Nova
# -------------------------------
download_ksnova() {
    echo "📥 Downloading KS Nova (created by $AUTHOR)..."
    if wget -q --show-progress "$URL" -O "$FILE_NAME"; then
        echo "✅ Download successful! KS Nova created by $AUTHOR."
    else
        error_exit
    fi
}

# -------------------------------
# Function: Make executable
# -------------------------------
make_executable() {
    if chmod +x "$FILE_NAME"; then
        echo "⚡ Made $FILE_NAME executable! KS Nova created by $AUTHOR."
    else
        error_exit
    fi
}

# -------------------------------
# Function: Move to target directory
# -------------------------------
move_to_target() {
    echo "🚀 Moving $FILE_NAME to $TARGET_DIR..."
    if [ "$TARGET_DIR" = "$NON_ROOT_DIR" ]; then
        mv "$FILE_NAME" "$TARGET_DIR/" || error_exit
    else
        sudo mv "$FILE_NAME" "$TARGET_DIR/" || error_exit
    fi
    echo "✅ KS Nova installed successfully! Created by $AUTHOR."
    echo "Run it using: $TARGET_DIR/$FILE_NAME"
}

# -------------------------------
# Installer Workflow
# -------------------------------
echo "👋 Welcome! KS Nova is created by $AUTHOR."
check_dependencies
select_target_dir
download_ksnova
make_executable
move_to_target

# -------------------------------
# Optional: Verify installation
# -------------------------------
if "$TARGET_DIR/$FILE_NAME" --help >/dev/null 2>&1; then
    echo "🎉 KS Nova is ready to use! Created by $AUTHOR."
else
    echo "⚠️ Installation completed but verification failed. KS Nova created by $AUTHOR."
fi
