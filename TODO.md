# NixOS Configuration TODO

## Medium Priority

### 1. ✅ Hardcoded Paths
**Status**: Completed
**Impact**: Medium - Improves maintainability and portability

- [x] Update hyprpaper.nix to use `${personal.paths.*}`
- [x] Update sddm.nix to use `${personal.paths.*}`
- [x] Update spotify.nix to use `${personal.paths.*}`
- [x] Add spotifydCache path to personal.nix

**Completed**: All hardcoded paths now reference `personal.nix` for easier maintenance.

### 2. ✅ Waybar Battery Info on Desktop
**Status**: Completed
**Impact**: Low - Cleaner config, battery modules only on laptop

Removed laptop-specific modules from base Waybar config and added them to MBP15-specific home.nix.

**Files updated**:
- `modules/waybar/waybar.nix` - Removed battery, backlight modules
- `hosts/mbp15/home.nix` - Added laptop-specific modules with lib.mkBefore

### 3. ✅ Duplicate Shell Aliases
**Status**: Completed
**Impact**: Low - Reduced maintenance burden

Extracted shell aliases to `personal.nix` for sharing between bash and zsh.

**Files updated**:
- `personal.nix` - Added `shellAliases` attribute
- `home.nix` - Now uses `personal.shellAliases`
- `modules/zsh.nix` - Now uses `personal.shellAliases`

### 4. ✅ Binary Cache Configuration
**Status**: Completed
**Impact**: High - Significantly faster rebuilds

Added binary cache substituters for faster package downloads.

**Files updated**:
- `hosts/common/default.nix` - Added nix-community and hyprland cachix caches

**Caches added**:
- cache.nixos.org (default)
- nix-community.cachix.org
- hyprland.cachix.org

### 5. ✅ System Monitoring
**Status**: Completed
**Impact**: Medium - Better system visibility

Added comprehensive system monitoring with automated disk space checks.

**Files created**:
- `modules/monitoring.nix` - Monitoring tools and systemd services

**Features added**:
- System resource monitoring tools (htop, btop, iotop, iftop, nethogs)
- Automated daily disk space monitoring with notifications
- sysstat for system statistics collection

### 6. ✅ Explicit Firewall Rules Documentation
**Status**: Completed
**Impact**: Medium - Security clarity

Documented all firewall rules with detailed comments explaining each port and interface.

**Files updated**:
- `hosts/common/default.nix` - Comprehensive firewall documentation
- `modules/hyprland-control.nix` - Added firewall usage note

## Low Priority

### 7. ✅ Flake Update Automation
**Status**: Completed
**Impact**: Low - Convenience

Implemented automated weekly flake updates with systemd timer.

**Files created**:
- `modules/flake-update.nix` - Systemd service and timer for weekly updates

**Features**:
- Weekly automated flake updates
- Logging to ~/.flake-update.log
- Desktop notifications when updates complete
- Randomized delay to avoid all updates at same time

### 8. ✅ CI/CD for Configuration Validation
**Status**: Completed
**Impact**: Low - Catch errors early

Added GitHub Actions workflow for automatic configuration validation.

**Files created**:
- `.github/workflows/nix-check.yml` - CI workflow

**Features**:
- Runs `nix flake check` on all commits and PRs
- Builds both desktop and mbp15 configurations
- Uses Nix cache for faster builds
- Validates configuration before deployment

### 9. ⏳ Development Shells
**Status**: Pending
**Impact**: Low - Developer experience

Add `devShells` output to flake for project-specific environments.

**Examples**:
- Python development shell
- Node.js development shell
- Rust development shell

### 10. ✅ Home-Manager Standalone Configuration
**Status**: Completed
**Impact**: Low - Flexibility

Added `homeConfigurations` output for standalone home-manager usage (non-NixOS).

**Files updated**:
- `flake.nix` - Added `mkHomeConfig` helper and `homeConfigurations` output

**Usage**:
```bash
# Switch to standalone home-manager config
home-manager switch --flake /home/faelterman/.dotfiles#faelterman@desktop
home-manager switch --flake /home/faelterman/.dotfiles#faelterman@mbp15
```

**Features**:
- Standalone home-manager configurations for both desktop and mbp15
- Includes Catppuccin theming
- Can be used on non-NixOS systems or for testing home configs independently

### 11. ⏳ Backup Strategy Documentation
**Status**: Pending
**Impact**: Medium - Data safety

Document or automate backups for:
- `/home/faelterman/secrets/`
- Important personal files
- Configuration state

**Ideas**:
- Borg backup configuration
- Restic with cloud storage
- Simple rsync scripts

## Completed ✅

- [x] Fix critical typos (hypridle.nix, binds.nix)
- [x] Implement agenix secrets management
- [x] Add Bluetooth support for MBP15
- [x] Centralized personal configuration (personal.nix)
- [x] Update .gitignore for secrets
- [x] Fix hostname consistency (nixos-desktop)
- [x] Create yazi.md cheatsheet

---

**Last Updated**: December 14, 2025
