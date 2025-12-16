# ███████╗██╗  ██╗ ██████╗███████╗██╗     
# ██╔════╝╚██╗██╔╝██╔════╝██╔════╝██║     
# █████╗   ╚███╔╝ ██║     █████╗  ██║     
# ██╔══╝   ██╔██╗ ██║     ██╔══╝  ██║     
# ███████╗██╔╝ ██╗╚██████╗███████╗███████╗
# ╚══════╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚══════╝
{ pkgs, ... }:
{
  # Create a wrapper script for Word Web
  home.packages = with pkgs; [
    (writeScriptBin "excel" ''
      #!${pkgs.bash}/bin/bash
      ${pkgs.chromium}/bin/chromium \
        --user-data-dir="$HOME/.config/chromium-excel" \
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
  home.file.".local/share/icons/hicolor/256x256/apps/excel.png".source = pkgs.fetchurl {
    url = "https://excel.office.com/pwa/icon.png";
    sha256 = "1wrybzlkdcya721cxn67zs17xq944ayh5rjjpssyp338rhkqdrdq";
  };
}