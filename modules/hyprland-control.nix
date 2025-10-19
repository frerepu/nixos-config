# ██╗  ██╗██╗   ██╗██████╗ ██████╗ ██╗      █████╗ ███╗   ██╗██████╗
# ██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗██║     ██╔══██╗████╗  ██║██╔══██╗
# ███████║ ╚████╔╝ ██████╔╝██████╔╝██║     ███████║██╔██╗ ██║██║  ██║
# ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██╗██║     ██╔══██║██║╚██╗██║██║  ██║
# ██║  ██║   ██║   ██║     ██║  ██║███████╗██║  ██║██║ ╚████║██████╔╝
# ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝
#
# Hyprland Remote Control Module
# Provides hyprctl-remote wrapper for Bitfocus Companion SSH control
#
# Usage in Bitfocus Companion:
#   ssh -i ~/.ssh/companion_key localhost "hyprctl-remote dispatch workspace 1" 2>/dev/null

{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.hyprland-control;

  # Create hyprctl wrapper that finds the Hyprland instance automatically
  hyprctl-remote = pkgs.writeShellScriptBin "hyprctl-remote" ''
    # Suppress all stderr output (including starship warnings)
    exec 2>/dev/null

    # Find the active Hyprland instance signature
    SIGNATURE=$(ls -t /run/user/$(id -u)/hypr/ 2>/dev/null | grep -v lock | head -n 1)

    if [ -z "$SIGNATURE" ]; then
      echo "Error: Hyprland instance not found" >&2
      exit 1
    fi

    export HYPRLAND_INSTANCE_SIGNATURE="$SIGNATURE"
    exec ${pkgs.hyprland}/bin/hyprctl "$@"
  '';

  # Create wtype wrapper for text input via SSH
  wtype-remote = pkgs.writeShellScriptBin "wtype-remote" ''
    # Set up Wayland environment
    export WAYLAND_DISPLAY=wayland-1
    export XDG_RUNTIME_DIR=/run/user/$(id -u)

    exec ${pkgs.wtype}/bin/wtype "$@" 2>/dev/null
  '';

in {
  options.services.hyprland-control = {
    enable = mkEnableOption "Hyprland remote control for Bitfocus Companion";

    user = mkOption {
      type = types.str;
      default = "faelterman";
      description = "User to add SSH keys for Companion control";
    };

    sshAuthorizedKeys = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "SSH public keys authorized for Companion control";
      example = [ "ssh-ed25519 AAAAC3NzaC1... companion@bitfocus" ];
    };
  };

  config = mkIf cfg.enable {
    # Install hyprctl-remote and wtype-remote wrappers
    environment.systemPackages = [ hyprctl-remote wtype-remote ];

    # Enable SSH server for Companion connections
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    # Add authorized keys if provided
    users.users.${cfg.user} = mkIf (cfg.sshAuthorizedKeys != []) {
      openssh.authorizedKeys.keys = cfg.sshAuthorizedKeys;
    };
  };
}