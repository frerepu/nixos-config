{ pkgs, ... }: {
  # MacBook Pro specific home configuration
  imports = [
    ../../home.nix
    ./hyprland.nix
  ];
}