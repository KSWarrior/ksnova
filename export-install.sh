#!/usr/bin/env bash
set -euo pipefail

# -------------------------------
# KS Nova Installer
# Created by KS Warrior
# -------------------------------

URL="https://raw.githubusercontent.com/KSWarrior/ksnova/refs/heads/main/ksnova-linux"
INSTALL_DIR="/usr/local/bin/ksn"
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
# Function: Create install directory
# -------------------------------
create_install_dir() {
    mkdir -p "$INSTALL_DIR" || error_exit
    echo "✅ Directory created: $INSTALL_DIR"
}

# -------------------------------
# Function: Download KS Nova
# -------------------------------
download_ksnova() {
    echo "📥 Downloading KS Nova (created by $AUTHOR)..."
    if wget -q --show-progress "$URL" -O "$INSTALL_DIR/$FILE_NAME"; then
        echo "✅ Download successful! KS Nova created by $AUTHOR."
    else
        error_exit
    fi
}

# -------------------------------
# Function: Make executable
# -------------------------------
make_executable() {
    chmod +x "$INSTALL_DIR/$FILE_NAME" || error_exit
    echo "⚡ Made $FILE_NAME executable! KS Nova created by $AUTHOR."
}

# -------------------------------
# Function: Export PATH
# -------------------------------
export_path() {
    if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
        echo "📌 Adding $INSTALL_DIR to PATH..."
        echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> ~/.bashrc
        echo "✅ PATH updated. Restart your terminal or run: source ~/.bashrc"
    fi
}

# -------------------------------
# Installer Workflow
# -------------------------------
echo "👋 Welcome! KS Nova is created by $AUTHOR."
check_dependencies
create_install_dir
download_ksnova
make_executable
export_path

# -------------------------------
# Optional: Verify installation
# -------------------------------
if "$INSTALL_DIR/$FILE_NAME" --help >/dev/null 2>&1; then
    echo "🎉 KS Nova is ready to use! Run: $FILE_NAME"
else
    echo "⚠️ Installation completed but verification failed. KS Nova created by $AUTHOR."
fi
