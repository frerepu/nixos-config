{ config, pkgs, ... }:

{
  # Qt theming with Catppuccin Kvantum
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  # Enable Catppuccin Kvantum theme (using correct option names)
  catppuccin.kvantum = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
    apply = false;  # Don't auto-apply to keep config writable
  };

  # Install Kvantum packages
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qtstyleplugin-kvantum
  ];
}
