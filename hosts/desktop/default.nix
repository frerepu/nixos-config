# ██████╗ ███████╗███████╗██╗  ██╗████████╗ ██████╗ ██████╗
# ██╔══██╗██╔════╝██╔════╝██║ ██╔╝╚══██╔══╝██╔═══██╗██╔══██╗
# ██║  ██║█████╗  ███████╗█████╔╝    ██║   ██║   ██║██████╔╝
# ██║  ██║██╔══╝  ╚════██║██╔═██╗    ██║   ██║   ██║██╔═══╝
# ██████╔╝███████╗███████║██║  ██╗   ██║   ╚██████╔╝██║
# ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝
#
# Desktop host configuration
# Minimal overrides - most config inherited from common modules

{ config, lib, pkgs, inputs, ... }: {
  imports = [
    ./hardware.nix
    ../common/desktop.nix
    ../../modules/docker.nix
  ];

  # Host-specific configuration
  networking.hostName = "nixos";
  networking.interfaces.enp4s0f0.useDHCP = true;

  # Desktop-specific SDDM background (optional, can be uncommented)
  # catppuccin.sddm = {
  #   background = "/home/faelterman/.config/background/wallhaven-8x16mo.png";
  #   loginBackground = true;
  # };
}