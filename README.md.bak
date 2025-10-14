# 🏠 Personal NixOS Dotfiles

My personal NixOS configuration with Hyprland, designed for deployment across multiple hosts including desktop and MacBook Pro systems.

## 📋 Overview

This repository contains a modular NixOS configuration that supports:

- **Multiple hosts** with shared and host-specific configurations
- **Hyprland** window manager with host-optimized settings
- **Catppuccin** theming across all applications
- **Home Manager** for user-space configuration
- **Flake-based** setup for reproducible builds

## 🖥️ Current Hosts

- **`desktop`** - Primary desktop system (nixos hostname)
- **`mbp15`** - MacBook Pro 15" laptop

## 📁 Repository Structure

```
.dotfiles/
├── flake.nix                 # Main flake configuration
├── home.nix                  # Shared home-manager config
├── hosts/
│   ├── common/
│   │   └── default.nix       # Common system configuration
│   ├── desktop/
│   │   ├── default.nix       # Desktop-specific system config
│   │   ├── hardware.nix      # Hardware configuration
│   │   ├── home.nix          # Desktop home-manager config
│   │   └── hyprland.nix      # Desktop Hyprland config
│   └── mbp15/
│       ├── default.nix       # MacBook Pro system config
│       ├── hardware.nix      # Hardware configuration
│       ├── home.nix          # MacBook Pro home-manager config
│       └── hyprland.nix      # MacBook Pro Hyprland config
├── modules/
│   ├── hyprland/
│   │   ├── common.nix        # Universal Hyprland settings
│   │   ├── hypridle.nix      # Idle management
│   │   ├── hyprlock.nix      # Lock screen
│   │   └── hyprpaper.nix     # Wallpaper management
│   ├── waybar/               # Status bar configuration
│   ├── wofi/                 # Application launcher
│   └── [other modules...]
└── guide.md                  # Detailed installation guide
```

## 🚀 Quick Start

### For Existing Hosts

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
   ```

2. **Create symlink:**
   ```bash
   sudo ln -sf /home/faelterman/.dotfiles /etc/nixos
   ```

3. **Apply configuration:**
   ```bash
   sudo nixos-rebuild switch --flake /etc/nixos#hostname
   ```

### Available Build Targets

- `sudo nixos-rebuild switch --flake .#desktop` - Desktop system
- `sudo nixos-rebuild switch --flake .#mbp15` - MacBook Pro

## 🔧 Adding a New Host

### 1. Create Host Directory Structure

```bash
mkdir -p hosts/newhostname
cd hosts/newhostname
```

### 2. Create Required Files

**`hosts/newhostname/default.nix`:**
```nix
{ config, pkgs, inputs, ... }: {
  imports = [
    ./hardware.nix
    inputs.catppuccin.nixosModules.catppuccin  # if using catppuccin
  ];

  # Host-specific configuration
  networking.hostName = "newhostname";

  # Add host-specific services, packages, etc.
  # See existing hosts for examples
}
```

**`hosts/newhostname/home.nix`:**
```nix
{ pkgs, ... }: {
  # Host-specific home configuration
  imports = [
    ../../home.nix
    ./hyprland.nix  # if using Hyprland
  ];
}
```

**`hosts/newhostname/hyprland.nix`:** (if using Hyprland)
```nix
{ pkgs, ... }: {
  # Host-specific Hyprland configuration
  wayland.windowManager.hyprland.settings = {
    # Monitor configuration
    monitor = [
      "MONITOR-NAME,resolution@refresh,position,scale"
    ];

    # Host-specific input/output settings
    # See existing hosts for examples
  };
}
```

### 3. Create Top-Level Configuration

**`newhostname-configuration.nix`:**
```nix
{ config, pkgs, ... }: {
  imports = [
    ./hosts/common/default.nix
    ./hosts/newhostname/default.nix
  ];
}
```

### 4. Update Flake Configuration

Add to `flake.nix` in the `nixosConfigurations` section:
```nix
newhostname = nixpkgs-unstable.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs; };
  modules = [
    ./newhostname-configuration.nix
    home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs; };
        users.faelterman = { pkgs, ... }: {
          imports = [
            ./hosts/newhostname/home.nix
            catppuccin.homeModules.catppuccin
          ];
        };
      };
    }
  ];
};
```

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
# Create dotfiles symlink
sudo ln -sf /home/faelterman/.dotfiles /etc/nixos

# Apply configuration
sudo nixos-rebuild switch --flake /etc/nixos#HOSTNAME

# Configure git
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## 🎨 Key Features

### Hyprland Configuration
- **Common settings** shared across all hosts (keybindings, window rules)
- **Host-specific** monitor configurations and optimizations
- **Desktop**: High refresh rate, enhanced effects, multi-monitor support
- **Laptop**: Power efficiency, trackpad gestures, brightness controls

### Package Management
- **System packages** defined per host in `hosts/*/default.nix`
- **User packages** in `home.nix` organized by category
- **Development tools, communication apps, media tools** all included

### Theming
- **Catppuccin** theme across all applications
- **Consistent** colors and fonts
- **SDDM** login manager with Catppuccin theming

## 🔍 Useful Commands

```bash
# Rebuild current system
sudo nixos-rebuild switch --flake /etc/nixos

# Rebuild specific host
sudo nixos-rebuild switch --flake /etc/nixos#hostname

# Test configuration without switching
sudo nixos-rebuild test --flake /etc/nixos#hostname

# Check what will be built
nix build .#nixosConfigurations.hostname.config.system.build.toplevel --dry-run

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
- **Git history** contains the evolution of this setup - check commits for changes
- **Issues and improvements** are welcome via issues/PRs

---

*This dotfiles repository powers my daily NixOS workflow across desktop and laptop systems.*