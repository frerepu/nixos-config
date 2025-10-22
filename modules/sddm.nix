{ config, pkgs, lib, ... }:

{
  # SDDM Display Manager Configuration
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
  };

  # Install Catppuccin SDDM theme
  environment.systemPackages = [
    pkgs.catppuccin-sddm
  ];

  # Catppuccin theme configuration
  catppuccin.sddm = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
    background = "/home/faelterman/.dotfiles/wallpapers/wp.jpg";
    loginBackground = true;
  };

  # Activation script to ensure Hyprland session is available
  system.activationScripts = {
    sddm-session = {
      text = ''
        mkdir -p /usr/share/wayland-sessions
        ln -sfn ${pkgs.hyprland}/share/wayland-sessions/hyprland.desktop /usr/share/wayland-sessions/
      '';
    };
  };
}