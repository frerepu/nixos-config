# ██████╗ ███████╗███████╗██╗  ██╗████████╗ ██████╗ ██████╗
# ██╔══██╗██╔════╝██╔════╝██║ ██╔╝╚══██╔══╝██╔═══██╗██╔══██╗
# ██║  ██║█████╗  ███████╗█████╔╝    ██║   ██║   ██║██████╔╝
# ██║  ██║██╔══╝  ╚════██║██╔═██╗    ██║   ██║   ██║██╔═══╝
# ██████╔╝███████╗███████║██║  ██╗   ██║   ╚██████╔╝██║
# ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝
#
# Desktop host configuration
# Minimal overrides - most config inherited from common modules

{ config, lib, pkgs, inputs, ... }:
let
  personal = import ../../personal.nix;
in
{
  imports = [
    ./hardware.nix
    ../common/desktop.nix
    ../../modules/docker.nix
    ../../modules/hyprland-control.nix
  ];

  # Host-specific configuration
  networking.hostName = "nixos-desktop";
  networking.interfaces.enp4s0f0.useDHCP = true;

  # Use Zen kernel for better desktop performance
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Enable Hyprland remote control via SSH for Bitfocus Companion
  services.hyprland-control = {
    enable = true;
    sshAuthorizedKeys = [
      personal.ssh.desktopKey
    ];
  };
}