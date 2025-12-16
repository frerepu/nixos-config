# ███████╗██╗  ██╗ █████╗ ██████╗ ███████╗██████╗  ██████╗ ██╗███╗   ██╗████████╗
# ██╔════╝██║  ██║██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔═══██╗██║████╗  ██║╚══██╔══╝
# ███████╗███████║███████║██████╔╝█████╗  ██████╔╝██║   ██║██║██╔██╗ ██║   ██║
# ╚════██║██╔══██║██╔══██║██╔══██╗██╔══╝  ██╔═══╝ ██║   ██║██║██║╚██╗██║   ██║
# ███████║██║  ██║██║  ██║██║  ██║███████╗██║     ╚██████╔╝██║██║ ╚████║   ██║
# ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝      ╚═════╝ ╚═╝╚═╝  ╚═══╝   ╚═╝
{ pkgs, ... }:
{
  # Create a wrapper script for SharePoint Web
  home.packages = with pkgs; [
    (writeScriptBin "sharepoint" ''
      #!${pkgs.bash}/bin/bash
      ${pkgs.chromium}/bin/chromium \
        --user-data-dir="$HOME/.config/chromium-sharepoint" \
        --app=https://www.office.com/launch/sharepoint \
        --class=sharepoint-web
    '')
  ];

  # Create desktop entry for Wofi integration
  xdg.desktopEntries.sharepoint = {
    name = "SharePoint";
    genericName = "Collaboration Platform";
    exec = "sharepoint";
    icon = "sharepoint";
    categories = [ "Office" "Network" ];
    type = "Application";
  };

  # Add icon for the application
  # Note: SharePoint doesn't have a dedicated PWA icon URL
  # Using Excel icon as a placeholder - you can replace with a custom icon
  home.file.".local/share/icons/hicolor/256x256/apps/sharepoint.png".source = pkgs.fetchurl {
    url = "https://excel.office.com/pwa/icon.png";
    sha256 = "1wrybzlkdcya721cxn67zs17xq944ayh5rjjpssyp338rhkqdrdq";
  };
}
