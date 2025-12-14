# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal NixOS dotfiles repository using a modular, DRY (Don't Repeat Yourself) architecture with flakes and home-manager. The configuration supports multiple hosts (desktop and MacBook Pro) with shared base configurations and host-specific overrides. All graphical hosts use Hyprland with Catppuccin theming.

## Build and Development Commands

### Basic Operations

```bash
# Rebuild current host (auto-detects hostname)
sudo nixos-rebuild switch --flake /home/faelterman/.dotfiles#$(hostname)

# Rebuild specific host
sudo nixos-rebuild switch --flake /home/faelterman/.dotfiles#desktop
sudo nixos-rebuild switch --flake /home/faelterman/.dotfiles#mbp15

# Test configuration without making it default
sudo nixos-rebuild test --flake /home/faelterman/.dotfiles#$(hostname)

# Build without activating
sudo nixos-rebuild build --flake /home/faelterman/.dotfiles#$(hostname)

# Preview changes (dry run)
nixos-rebuild dry-build --flake /home/faelterman/.dotfiles#$(hostname)
```

### Update and Maintenance

```bash
# Update all flake inputs
cd /home/faelterman/.dotfiles
nix flake update

# Update specific input
nix flake lock --update-input nixpkgs-unstable
nix flake lock --update-input home-manager
nix flake lock --update-input catppuccin

# Check flake validity
nix flake check /home/faelterman/.dotfiles

# Clean up old generations
sudo nix-collect-garbage -d
sudo nix-store --optimise
```

## Architecture

### Three-Layer Configuration System

1. **Common Base** (`hosts/common/default.nix`): System-wide base configuration including networking, fonts, base packages, common services (Tailscale, SSH), and firewall rules
2. **Desktop Base** (`hosts/common/desktop.nix`): Shared desktop environment configuration for all graphical hosts including Hyprland, SDDM, PipeWire audio, XDG portals, and Wayland environment variables
3. **Host-Specific** (`hosts/{hostname}/default.nix`): Minimal host-specific overrides for hardware, hostname, network interfaces, and special features

### mkHost Helper Function

The `flake.nix` contains a `mkHost` helper function that eliminates boilerplate when adding new hosts. It automatically:
- Imports common configuration (`hosts/common/default.nix`)
- Sets up home-manager with user packages
- Applies Catppuccin theming
- Wires together NixOS and home-manager modules

### Current Hosts

- **desktop**: Primary desktop system (hostname: `nixos`)
  - Network interface: `enp4s0f0`
  - Includes Docker and Hyprland remote control service
  - High refresh rate monitor setup

- **mbp15**: MacBook Pro 15" laptop
  - Laptop-optimized settings (power management, touchpad gestures)
  - Brightness controls and battery optimization

### Modular Home-Manager Configuration

Base user configuration is in `home.nix` with imports from `modules/`:

- **Hyprland**: `modules/hyprland/` contains common settings, keybindings, idle management, lockscreen, and wallpaper configuration
- **Shell**: Starship prompt, bash/zsh with aliases, yazi file manager
- **Desktop utilities**: Waybar, Wofi launcher, notification center
- **Applications**: VS Code, git, bat, rbw password manager, Microsoft Office PWAs

Host-specific home-manager configs (`hosts/{hostname}/home.nix`) import the base and add host-specific Hyprland settings.

## Adding a New Host

1. **Create host directory structure**:
   ```bash
   mkdir -p hosts/newhostname
   ```

2. **Create `hosts/newhostname/default.nix`**:
   ```nix
   { config, pkgs, inputs, ... }: {
     imports = [
       ./hardware.nix
       ../common/desktop.nix  # If graphical
     ];

     networking.hostName = "newhostname";
     networking.interfaces.INTERFACE.useDHCP = true;

     # Add host-specific packages/services here
   }
   ```

3. **Create `hosts/newhostname/home.nix`**:
   ```nix
   { pkgs, ... }: {
     imports = [
       ../../home.nix
       ./hyprland.nix  # If using Hyprland
     ];
   }
   ```

4. **Create `hosts/newhostname/hyprland.nix`** (for Hyprland hosts):
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

5. **Update `flake.nix`**:
   ```nix
   newhostname = mkHost {
     hostname = "newhostname";
     hostConfig = ./hosts/newhostname/default.nix;
     homeConfig = ./hosts/newhostname/home.nix;
   };
   ```

## Important Configuration Details

### Username and Paths
- Primary user: `faelterman`
- Dotfiles location: `/home/faelterman/.dotfiles`
- Tailscale auth key: `/home/faelterman/secrets/tsauthkeyfile`

### Flake Inputs
- `nixpkgs-unstable`: Rolling release NixOS packages
- `home-manager`: User-space configuration management
- `catppuccin`: System-wide theming

### Common Settings
- Timezone: `Europe/Brussels`
- Locale: `en_US.UTF-8` with Belgian regional settings
- Keyboard: Belgian layout (`be`)
- Experimental features: `nix-command`, `flakes`

### Services
- **Tailscale**: Exit node enabled, advertising routes `172.16.10.0/24`
- **SSH**: Enabled on all hosts
- **Docker**: Desktop host only (in `modules/docker.nix`)
- **Hyprland remote control**: Desktop host only (via `modules/hyprland-control.nix`)

### Hyprland Configuration Structure

Common Hyprland settings in `modules/hyprland/common.nix` use `lib.mkDefault` for all settings, allowing host-specific overrides in `hosts/{hostname}/hyprland.nix`. This pattern enables shared defaults while preserving per-host customization for:
- Monitor configurations
- Input device settings (touchpad on laptop vs mouse on desktop)
- Performance settings (animations, blur effects)
- Power management options

## File Organization Principles

- Keep common configurations in `hosts/common/`
- Host-specific files should only contain overrides and unique settings
- Use `lib.mkDefault` in common modules to allow host-specific overrides
- Organize home-manager modules by application in `modules/`
- Place service-specific configurations (like Bitfocus Companion) in `services/`

## Key Modules

- `modules/hyprland-control.nix`: SSH-based remote control for Hyprland (desktop only)
- `modules/docker.nix`: Docker and docker-compose setup
- `modules/sddm.nix`: Display manager with Catppuccin theme
- `modules/microsoft/`: Microsoft Office web apps as desktop applications
- `modules/waybar/`: Status bar configuration
- `modules/wofi/`: Application launcher
