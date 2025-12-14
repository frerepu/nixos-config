# 🏠 Personal NixOS Dotfiles

My personal NixOS configuration with Hyprland, designed for deployment across multiple hosts including desktop and MacBook Pro systems.

## 📋 Overview

This repository contains a modular NixOS configuration that supports:

- **Multiple hosts** with shared and host-specific configurations
- **DRY architecture** using helper functions to eliminate duplication
- **Hyprland** Wayland compositor with host-optimized settings
- **Catppuccin** theming across all applications
- **Home Manager** for declarative user-space configuration
- **Flake-based** setup for reproducible builds
- **Complete desktop environment** with Waybar, Wofi, and modern viewers
- **System services** including Tailscale, Docker, and OneDrive integration

## 🖥️ Current Hosts

- **`desktop`** - Primary desktop system (nixos hostname)
- **`mbp15`** - MacBook Pro 15" laptop

## 📁 Repository Structure

```
.dotfiles/
├── flake.nix                 # Main flake with mkHost helper
├── home.nix                  # Shared home-manager config
├── hosts/
│   ├── common/
│   │   ├── default.nix       # Common system configuration
│   │   └── desktop.nix       # Shared desktop/graphical configuration
│   ├── desktop/
│   │   ├── default.nix       # Desktop-specific overrides (minimal)
│   │   ├── hardware.nix      # Hardware configuration
│   │   ├── home.nix          # Desktop home-manager config
│   │   └── hyprland.nix      # Desktop Hyprland overrides
│   └── mbp15/
│       ├── default.nix       # Laptop-specific config (power, touchpad)
│       ├── hardware.nix      # Hardware configuration
│       ├── home.nix          # MacBook Pro home-manager config
│       └── hyprland.nix      # MacBook Pro Hyprland overrides
├── modules/
│   ├── hyprland/
│   │   ├── default.nix       # Hyprland module loader
│   │   ├── common.nix        # Universal Hyprland settings
│   │   ├── binds.nix         # Keybindings
│   │   ├── hypridle.nix      # Idle management
│   │   ├── hyprlock.nix      # Lock screen
│   │   └── hyprpaper.nix     # Wallpaper management
│   ├── waybar/               # Status bar configuration
│   ├── wofi/                 # Application launcher
│   └── [other modules...]
└── guide.md                  # Detailed installation guide
```

## 🏗️ Architecture

### Modular Design

The configuration uses a **three-layer architecture**:

1. **`hosts/common/default.nix`** - Base system configuration (networking, fonts, base packages)
2. **`hosts/common/desktop.nix`** - Shared desktop environment (Hyprland, greetd, audio, XDG portals)
3. **`hosts/{hostname}/default.nix`** - Host-specific overrides (hardware, hostname, special features)

### DRY with mkHost Helper

The `flake.nix` uses a `mkHost` helper function to eliminate duplication:

```nix
mkHost = { hostname, hostConfig, homeConfig }:
  nixpkgs-unstable.lib.nixosSystem {
    # Automatically imports common config
    # Sets up home-manager
    # Applies catppuccin theming
  };
```

This means adding a new host requires **zero boilerplate** - just call `mkHost` with your host paths.

## 🚀 Quick Start

### For Existing Hosts

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
   ```

2. **Create symlink (optional but recommended):**
   ```bash
   sudo ln -sf /home/faelterman/.dotfiles /etc/nixos
   ```

3. **Apply configuration:**
   ```bash
   sudo nixos-rebuild switch --flake ~/.dotfiles#hostname
   ```

### Available Build Targets

- `sudo nixos-rebuild switch --flake .#desktop` - Desktop system
- `sudo nixos-rebuild switch --flake .#mbp15` - MacBook Pro

## 🔧 Adding a New Host

Thanks to the refactored architecture, adding a new host is simple:

### 1. Create Host Directory Structure

```bash
mkdir -p hosts/newhostname
cd hosts/newhostname
```

### 2. Create Minimal Host Config

**`hosts/newhostname/default.nix`:**
```nix
{ config, pkgs, inputs, ... }: {
  imports = [
    ./hardware.nix
    ../common/desktop.nix  # If graphical, otherwise omit
  ];

  # Host-specific configuration
  networking.hostName = "newhostname";
  networking.interfaces.eth0.useDHCP = true;  # Adjust interface name

  # Add any host-specific packages, services, or overrides here
  # Most config is inherited from common modules
}
```

**`hosts/newhostname/home.nix`:**
```nix
{ pkgs, ... }: {
  imports = [
    ../../home.nix
    ./hyprland.nix  # If using Hyprland
  ];
}
```

**`hosts/newhostname/hyprland.nix`:** (if using Hyprland)
```nix
{ pkgs, ... }: {
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "MONITOR-NAME,resolution@refresh,position,scale"
    ];
    # Host-specific overrides only
  };
}
```

### 3. Update Flake Configuration

Add to `flake.nix` in the `nixosConfigurations` section:
```nix
newhostname = mkHost {
  hostname = "newhostname";
  hostConfig = ./hosts/newhostname/default.nix;
  homeConfig = ./hosts/newhostname/home.nix;
};
```

That's it! The `mkHost` helper handles all the boilerplate.

## 💻 Fresh NixOS Installation Steps

### 1. Install Minimal NixOS

1. Boot from NixOS installer USB
2. Connect to WiFi
3. Partition disk and mount to `/mnt`
4. Generate hardware config: `sudo nixos-generate-config --root /mnt`

### 2. Replace with Dotfiles

```bash
# Install git temporarily
nix-shell -p git

# Backup hardware config
sudo cp /mnt/etc/nixos/hardware-configuration.nix /tmp/

# Remove default config and clone dotfiles
sudo rm -rf /mnt/etc/nixos/*
sudo git clone https://github.com/yourusername/dotfiles.git /mnt/etc/nixos

# Copy hardware config to appropriate host
sudo cp /tmp/hardware-configuration.nix /mnt/etc/nixos/hosts/HOSTNAME/hardware.nix
```

### 3. Install System

```bash
# Install with your configuration
sudo nixos-install --flake /mnt/etc/nixos#HOSTNAME

# Set user password
sudo nixos-enter --root /mnt
passwd faelterman
exit

# Reboot
sudo reboot
```

### 4. Post-Installation Setup

```bash
# Create dotfiles symlink (optional)
sudo ln -sf /home/faelterman/.dotfiles /etc/nixos

# Apply configuration
sudo nixos-rebuild switch --flake ~/.dotfiles#HOSTNAME

# Configure git
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## 🎨 Key Features

### Hyprland Configuration
- **Common settings** shared across all hosts ([modules/hyprland/common.nix](modules/hyprland/common.nix))
- **Universal keybindings** in [modules/hyprland/binds.nix](modules/hyprland/binds.nix)
- **Host-specific** monitor configurations and optimizations
- **Desktop**: High refresh rate, enhanced effects, multi-monitor support
- **Laptop**: Power efficiency, trackpad gestures, brightness controls

### Package Management
- **System packages** defined in [hosts/common/default.nix](hosts/common/default.nix)
- **Desktop packages** in [hosts/common/desktop.nix](hosts/common/desktop.nix)
- **User packages** in [home.nix](home.nix) organized by category
- **Host-specific packages** only when needed (e.g., laptop power tools)

### Theming
- **Catppuccin** theme across all applications
- **Consistent** colors and fonts
- **greetd** login manager with Catppuccin theming

### File Management & Viewers
- **Thunar** file manager with plugins:
  - Archive support (thunar-archive-plugin)
  - Volume management (thunar-volman)
  - Thumbnail generation via tumbler service
- **Zathura** - Lightweight, keyboard-driven PDF viewer with Wayland support
- **imv** - Native Wayland image viewer for all common formats
- **XDG MIME associations** - Automatic file type handling with default applications

### Desktop Environment
- **Hyprland** - Dynamic tiling Wayland compositor
- **Waybar** - Customizable status bar with system information
- **Wofi** - Application launcher and dmenu replacement
- **SwayNotificationCenter** - Notification daemon and center
- **wlogout** - Logout menu with system actions
- **Hyprland utilities**:
  - hyprpaper - Wallpaper manager
  - hyprpicker - Color picker
  - hyprshot - Screenshot tool
  - hyprlock - Screen locker
  - hypridle - Idle management
  - hyprsunset - Blue light filter

### Applications
- **Development**: VS Code, Zed Editor, Claude Code, Node.js
- **Browsers**: Zen Browser (default), Chromium
- **Communication**: Teams for Linux, Webcord (Discord), Mumble, Element
- **Productivity**: Microsoft Office (PWAs), OneDrive
- **Media**: Spotify
- **Utilities**: Orca Slicer (3D printing), Yazi (terminal file manager)

### System Services
- **PipeWire** - Modern audio/video server
- **Tailscale** - Mesh VPN with exit node support
- **Flatpak** - Universal package management
- **OneDrive** - Cloud storage integration
- **Docker** - Containerization (desktop host only)

## 🔍 Useful Commands

```bash
# Rebuild current system
sudo nixos-rebuild switch --flake ~/.dotfiles

# Rebuild specific host
sudo nixos-rebuild switch --flake ~/.dotfiles#hostname

# Test configuration without switching
sudo nixos-rebuild test --flake ~/.dotfiles#hostname

# Check what will be built
sudo nixos-rebuild dry-build --flake ~/.dotfiles#hostname

# Update flake inputs
nix flake update

# Check flake
nix flake check
```

## 📚 Additional Resources

- **Detailed Installation Guide**: See [guide.md](./guide.md) for step-by-step MacBook Pro deployment
- **NixOS Manual**: https://nixos.org/manual/nixos/stable/
- **Home Manager**: https://github.com/nix-community/home-manager
- **Hyprland**: https://hyprland.org/

## 🤝 Notes

- This is a **personal configuration** - adapt paths, usernames, and preferences as needed
- **Hardware configurations** are auto-generated and host-specific
- **Refactored for DRY** - ~200 lines of duplication eliminated
- **Issues and improvements** are welcome via issues/PRs

## 📊 Refactoring Benefits

This configuration was recently refactored to eliminate duplication:

- ✅ **~200 lines** of duplicate code removed
- ✅ **70% reduction** in host-specific configuration size
- ✅ **DRY principle** applied with `mkHost` helper and shared desktop module
- ✅ **Clearer separation** between common and host-specific settings

---

*This dotfiles repository powers my daily NixOS workflow across desktop and laptop systems.*
