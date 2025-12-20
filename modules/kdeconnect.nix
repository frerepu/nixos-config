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
  # Install KDE Connect package with indicator and theming
  home.packages = with pkgs; [
    kdePackages.kdeconnect-kde
    catppuccin-kde  # KDE color schemes for Catppuccin
  ];

  # Enable KDE Connect service
  # This handles device discovery, pairing, and background services
  services.kdeconnect = {
    enable = true;
    indicator = true;  # Show system tray indicator
  };

  # Configure KDE apps to use Catppuccin Mocha theme
  # Reference: https://github.com/catppuccin/kde
  # Catppuccin Mocha color palette (RGB values)
  home.file.".config/kdeglobals".text = ''
    [General]
    ColorScheme=CatppuccinMocha
    font=CaskaydiaCove Nerd Font Mono,11,-1,5,50,0,0,0,0,0
    fixed=CaskaydiaCove Nerd Font Mono,11,-1,5,50,0,0,0,0,0
    smallestReadableFont=CaskaydiaCove Nerd Font Mono,10,-1,5,50,0,0,0,0,0
    toolBarFont=CaskaydiaCove Nerd Font Mono,11,-1,5,50,0,0,0,0,0
    menuFont=CaskaydiaCove Nerd Font Mono,11,-1,5,50,0,0,0,0,0

    [Colors:Window]
    BackgroundNormal=30,30,46
    ForegroundNormal=205,214,244

    [Colors:Button]
    BackgroundNormal=49,50,68
    ForegroundNormal=205,214,244

    [Colors:Selection]
    BackgroundNormal=203,166,247
    ForegroundNormal=17,17,27

    [Colors:Tooltip]
    BackgroundNormal=24,24,37
    ForegroundNormal=205,214,244

    [Colors:View]
    BackgroundNormal=30,30,46
    ForegroundNormal=205,214,244

    [KDE]
    widgetStyle=kvantum
  '';

  # Set KDE-specific environment variables to force Qt platform theme usage
  home.sessionVariables = {
    KDE_SESSION_VERSION = "5";  # Prevent KDE apps from looking for Plasma
  };

  # Note: Firewall rules are configured in hosts/common/desktop.nix
  # KDE Connect requires TCP and UDP ports 1714-1764 to be open
}
