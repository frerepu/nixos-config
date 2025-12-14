# ███████╗██╗      █████╗ ██╗  ██╗███████╗    ██╗   ██╗██████╗ ███████╗
# ██╔════╝██║     ██╔══██╗██║ ██╔╝██╔════╝    ██║   ██║██╔══██╗██╔════╝
# █████╗  ██║     ███████║█████╔╝ █████╗      ██║   ██║██████╔╝█████╗
# ██╔══╝  ██║     ██╔══██║██╔═██╗ ██╔══╝      ██║   ██║██╔═══╝ ██╔══╝
# ██║     ███████╗██║  ██║██║  ██╗███████╗    ╚██████╔╝██║     ██║
# ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝     ╚═════╝ ╚═╝     ╚═╝
#
# Automated flake update service
# Runs weekly to keep flake inputs up to date

{ config, pkgs, lib, ... }:

let
  personal = import ../personal.nix;
in
{
  # Service to update flake inputs
  systemd.services.flake-update = {
    description = "Update NixOS flake inputs";
    serviceConfig = {
      Type = "oneshot";
      User = personal.user.name;
      WorkingDirectory = personal.paths.dotfiles;
      ExecStart = pkgs.writeShellScript "flake-update" ''
        #!/bin/sh
        set -e

        # Update all flake inputs
        ${pkgs.nix}/bin/nix flake update

        # Log the update
        echo "Flake updated at $(date)" >> ${personal.user.homeDirectory}/.flake-update.log

        # Optional: Send notification if in graphical session
        if [ -n "$DISPLAY" ] || [ -n "$WAYLAND_DISPLAY" ]; then
          ${pkgs.libnotify}/bin/notify-send \
            "Flake Update" \
            "NixOS flake inputs have been updated. Review changes before rebuilding."
        fi
      '';
    };
  };

  # Timer to run flake update weekly
  systemd.timers.flake-update = {
    description = "Run flake update weekly";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
      RandomizedDelaySec = "1h";  # Randomize to avoid all updates at same time
    };
  };
}
