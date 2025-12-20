# ██╗  ██╗██████╗ ███████╗     ██████╗ ██████╗ ███╗   ██╗███╗   ██╗███████╗ ██████╗████████╗
# ██║ ██╔╝██╔══██╗██╔════╝    ██╔════╝██╔═══██╗████╗  ██║████╗  ██║██╔════╝██╔════╝╚══██╔══╝
# █████╔╝ ██║  ██║█████╗      ██║     ██║   ██║██╔██╗ ██║██╔██╗ ██║█████╗  ██║        ██║
# ██╔═██╗ ██║  ██║██╔══╝      ██║     ██║   ██║██║╚██╗██║██║╚██╗██║██╔══╝  ██║        ██║
# ██║  ██╗██████╔╝███████╗    ╚██████╗╚██████╔╝██║ ╚████║██║ ╚████║███████╗╚██████╗   ██║
# ╚═╝  ╚═╝╚═════╝ ╚══════╝     ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═╝
#
# KDE Connect - Connect your devices seamlessly
# Enables file sharing, notifications, clipboard sync, and remote control between devices
#
# References:
# - KDE Connect: https://kdeconnect.kde.org/
# - NixOS Wiki: https://nixos.wiki/wiki/KDE_Connect
# - Firewall ports: TCP/UDP 1714-1764
# - Home-manager options: https://nix-community.github.io/home-manager/options.xhtml#opt-services.kdeconnect.enable

{ config, lib, pkgs, ... }:

{
  # Install KDE Connect package with indicator
  home.packages = with pkgs; [
    kdePackages.kdeconnect-kde
  ];

  # Enable KDE Connect service
  # This handles device discovery, pairing, and background services
  services.kdeconnect = {
    enable = true;
    indicator = true;  # Show system tray indicator
  };

  # Note: Firewall rules are configured in hosts/common/desktop.nix
  # KDE Connect requires TCP and UDP ports 1714-1764 to be open
}
