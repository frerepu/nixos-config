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
    ../../modules/hyprland-control.nix
  ];

  # Host-specific configuration
  networking.hostName = "nixos";
  networking.interfaces.enp4s0f0.useDHCP = true;

  # Enable Hyprland remote control via SSH for Bitfocus Companion
  services.hyprland-control = {
    enable = true;
    sshAuthorizedKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPLSC7B0/1ZFrdVTZa+yhquy674nw+JTw0oT5/+/oKGo faelterman@nixos"
    ];
  };
}