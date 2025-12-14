# ██╗  ██╗ ██████╗ ███╗   ███╗███████╗
# ██║  ██║██╔═══██╗████╗ ████║██╔════╝
# ███████║██║   ██║██╔████╔██║█████╗
# ██╔══██║██║   ██║██║╚██╔╝██║██╔══╝
# ██║  ██║╚██████╔╝██║ ╚═╝ ██║███████╗
# ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝

{ pkgs, lib, ... }: {
  # MacBook Pro specific home configuration
  imports = [
    ../../home.nix
    ./hyprland.nix
  ];

  # Laptop-specific Waybar modules
  programs.waybar.settings = [{
    modules-right = lib.mkBefore [ "backlight" "battery" "battery#bat2" ];
  }];
}