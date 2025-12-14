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

### 5. ⏳ System Monitoring
**Status**: Pending
**Impact**: Medium - Better system visibility

Add monitoring tools or automation (btop is installed but could add more).

**Ideas**:
- System resource monitoring alerts
- Disk space monitoring
- Service health checks

### 6. ⏳ Explicit Firewall Rules Documentation
**Status**: Pending
**Impact**: Medium - Security clarity

Document all open ports and why they're needed.

**Files to update**:
- `hosts/common/default.nix` (add comments)
- `modules/docker.nix`
- `modules/hyprland-control.nix`

## Low Priority

### 7. ⏳ Flake Update Automation
**Status**: Pending
**Impact**: Low - Convenience

Add systemd timer for weekly `nix flake update`.

### 8. ⏳ CI/CD for Configuration Validation
**Status**: Pending
**Impact**: Low - Catch errors early

Add GitHub Actions to run `nix flake check` on commits.

### 9. ⏳ Development Shells
**Status**: Pending
**Impact**: Low - Developer experience

Add `devShells` output to flake for project-specific environments.

**Examples**:
- Python development shell
- Node.js development shell
- Rust development shell

### 10. ⏳ Home-Manager Standalone Configuration
**Status**: Pending
**Impact**: Low - Flexibility

Add `homeConfigurations` output for standalone home-manager usage (non-NixOS).

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
