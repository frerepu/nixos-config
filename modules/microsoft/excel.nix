# In your home-manager configuration (e.g., home.nix)
{ config, pkgs, ... }:

{
  # Create a wrapper script for Word Web
  home.packages = with pkgs; [
    (writeScriptBin "excel" ''
      #!${pkgs.bash}/bin/bash
      ${pkgs.chromium}/bin/chromium \
        --app=https://www.office.com/launch/excel \
        --class=excel-web
    '')
  ];

  # Create desktop entry for Wofi integration
  xdg.desktopEntries.excel = {
    name = "Excel";
    genericName = "Spreadsheat Processor";
    exec = "excel";
    icon = "excel";
    categories = [ "Office" "Spreadsheet" ];
    type = "Application";
  };

  # Add icon for the application
  home.file.".local/share/icons/excel.png".source = pkgs.fetchurl {
    url = "https://excel.office.com/pwa/icon.png";
    sha256 = "1wrybzlkdcya721cxn67zs17xq944ayh5rjjpssyp338rhkqdrdq"; # Run nix-prefetch-url to get the hash
  };
}