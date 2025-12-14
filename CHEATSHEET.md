# NixOS Multi-Host Configuration Cheatsheet

## Configuration Structure

```
.dotfiles/
├── flake.nix              # Main entry point with mkHost helper function
├── flake.lock             # Lock file for input versions
├── home.nix               # Base home-manager configuration
├── hosts/
│   ├── common/
│   │   ├── default.nix    # System-wide base config (networking, fonts, services)
│   │   └── desktop.nix    # Desktop environment config (Hyprland, SDDM, audio)
│   ├── desktop/
│   │   ├── default.nix    # Desktop host NixOS config
│   │   ├── home.nix       # Desktop host home-manager config
│   │   ├── hardware.nix   # Desktop hardware configuration
│   │   └── hyprland.nix   # Desktop Hyprland settings
│   └── mbp15/
│       ├── default.nix    # MacBook Pro host NixOS config
│       ├── home.nix       # MacBook Pro home-manager config
│       ├── hardware.nix   # MacBook Pro hardware configuration
│       └── hyprland.nix   # MacBook Pro Hyprland settings
└── modules/               # Reusable home-manager modules
    ├── hyprland/          # Hyprland configs (binds, hypridle, hyprlock, etc.)
    ├── waybar/            # Waybar configuration
    ├── wofi/              # Wofi launcher config
    ├── microsoft/         # Microsoft Office apps (PWAs)
    └── *.nix              # Individual app configs (git, zsh, vscode, etc.)
```

### Architecture
- **DRY Design**: Common config in `hosts/common/`, host-specific overrides in `hosts/<hostname>/`
- **mkHost Helper**: Flake helper function combines NixOS + home-manager + Catppuccin theme
- **Two Hosts**: `desktop` and `mbp15` with shared base and individual customizations
- **Flake Inputs**: nixpkgs-unstable, home-manager, catppuccin theme

---

## Essential Commands

### Building & Switching

```bash
# Rebuild and switch to new configuration (current host)
sudo nixos-rebuild switch --flake /home/faelterman/.dotfiles#$(hostname)

# Rebuild for specific host
sudo nixos-rebuild switch --flake /home/faelterman/.dotfiles#desktop
sudo nixos-rebuild switch --flake /home/faelterman/.dotfiles#mbp15

# Test configuration without switching boot default
sudo nixos-rebuild test --flake /home/faelterman/.dotfiles#$(hostname)

# Build only (don't activate)
sudo nixos-rebuild build --flake /home/faelterman/.dotfiles#$(hostname)

# Boot into new config (activate on next reboot)
sudo nixos-rebuild boot --flake /home/faelterman/.dotfiles#$(hostname)
```

### Updating

```bash
# Update all flake inputs (nixpkgs, home-manager, catppuccin)
cd /home/faelterman/.dotfiles
nix flake update

# Update specific input only
nix flake lock --update-input nixpkgs-unstable
nix flake lock --update-input home-manager
nix flake lock --update-input catppuccin

# After updating, rebuild to apply changes
sudo nixos-rebuild switch --flake /home/faelterman/.dotfiles#$(hostname)
```

### Flake Management

```bash
# Show flake metadata and outputs
nix flake metadata /home/faelterman/.dotfiles
nix flake show /home/faelterman/.dotfiles

# Check flake for errors
nix flake check /home/faelterman/.dotfiles

# Show what will be built/updated (dry-run)
nixos-rebuild dry-build --flake /home/faelterman/.dotfiles#$(hostname)
```

### Garbage Collection

```bash
# Delete old generations and free space
sudo nix-collect-garbage -d

# Delete generations older than X days
sudo nix-collect-garbage --delete-older-than 30d

# Optimize nix store (deduplicate)
sudo nix-store --optimise

# List all system generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
```

### Rollback & Recovery

```bash
# List generations
sudo nixos-rebuild list-generations

# Rollback to previous generation
sudo nixos-rebuild switch --rollback

# Switch to specific generation (e.g., 42)
sudo nixos-rebuild switch --profile-name system-42-link

# Boot into previous generation from GRUB (select at boot time)
```

### Development & Testing

```bash
# Enter development shell with packages
nix develop

# Build specific package from your config
nix build /home/faelterman/.dotfiles#nixosConfigurations.desktop.config.system.build.toplevel

# Evaluate configuration option
nixos-option services.tailscale.enable

# Check syntax of a nix file
nix-instantiate --parse /home/faelterman/.dotfiles/flake.nix
```

### Git Workflow

```bash
cd /home/faelterman/.dotfiles

# Check status and commit changes
git status
git add .
git commit -m "Description of changes"
git push

# View history
git log --oneline
```

---

## Quick Reference

### Common Tasks

| Task | Command |
|------|---------|
| Apply config changes | `sudo nixos-rebuild switch --flake ~/.dotfiles#$(hostname)` |
| Update all packages | `cd ~/.dotfiles && nix flake update && sudo nixos-rebuild switch --flake .#$(hostname)` |
| Clean old generations | `sudo nix-collect-garbage -d` |
| Test before applying | `sudo nixos-rebuild test --flake ~/.dotfiles#$(hostname)` |
| Rollback changes | `sudo nixos-rebuild switch --rollback` |

### File Locations

| Item | Path |
|------|------|
| Main config | `/home/faelterman/.dotfiles/flake.nix` |
| Desktop config | `/home/faelterman/.dotfiles/hosts/desktop/` |
| MBP config | `/home/faelterman/.dotfiles/hosts/mbp15/` |
| Shared system | `/home/faelterman/.dotfiles/hosts/common/default.nix` |
| Shared desktop | `/home/faelterman/.dotfiles/hosts/common/desktop.nix` |
| Home-manager modules | `/home/faelterman/.dotfiles/modules/` |

### Hostname Detection

Your config uses `$(hostname)` to auto-detect the current host. Make sure:
- Desktop hostname matches: `desktop`
- MacBook Pro hostname matches: `mbp15`

Check with: `hostname` or `hostnamectl`

---

## Tips

- Always commit config changes to git before major updates
- Test changes with `nixos-rebuild test` first on critical systems
- Keep flake.lock in git to ensure reproducible builds across hosts
- Use `--show-trace` flag for detailed error messages during debugging
- The `mkHost` helper in flake.nix handles NixOS + home-manager integration automatically
