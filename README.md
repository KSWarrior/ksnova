# 🚀 KS Nova

![KS Nova Banner](https://user-images.githubusercontent.com/yourusername/ks-nova-banner.gif)

**KS Nova** is a lightning-fast, ultra-robust CLI tool for managing game servers, panels, and custom packages.  
With a single command, you can install, update, uninstall, or run popular game panels like **Pterodactyl**, **Puffer**, and **Minecraft servers** effortlessly.

---

## ✨ Features

- ✅ **Easy Install** — Deploy Pterodactyl, Puffer, Drogen, and Minecraft servers in seconds.  
- ⚡ **Blazing Fast CLI** — Lightweight, responsive, and ready-to-go.  
- 🔄 **Update & Uninstall** — One-line commands to keep KS Nova fresh or remove it cleanly.  
- 🛠️ **Package Management** — Manage server packages like a pro.  
- 🎨 **Stylish Console Output** — Colorful logs, animated progress bars, and eye candy for your terminal.  
- 🖥️ **Cross-platform** — Works on Linux, macOS, and WSL out-of-the-box.  

---

## 🎬 Installation

Choose the method that fits your system:

1. **With sudo (recommended)**  
```bash
bash <(curl -s https://raw.githubusercontent.com/KSWarrior/ksnova/refs/heads/main/sudo-install.sh)
```
2. **With root access**
```bash
bash <(curl -s https://raw.githubusercontent.com/KSWarrior/ksnova/refs/heads/main/root-install.sh)
```
3. **User-only (export to PATH, no sudo/root required)**
```bash
bash <(curl -s https://raw.githubusercontent.com/KSWarrior/ksnova/refs/heads/main/export-install.sh)
```
4. **Without sudo/root ($HOME)**
```bash
bash <(curl -s https://raw.githubusercontent.com/KSWarrior/ksnova/refs/heads/main/home-install.sh)
```
> ⚡ KS Nova is installed in your home directory: $HOME/.ksnova/ksn
> To run KS Nova, use the full path:
>   $HOME/.ksnova/ksn/ksn [command]
> Example:
>   $HOME/.ksnova/ksn/ksn install pterodactyl panel
