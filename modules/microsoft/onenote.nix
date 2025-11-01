#  ██████╗ ███╗   ██╗███████╗███╗   ██╗ ██████╗ ████████╗███████╗
# ██╔═══██╗████╗  ██║██╔════╝████╗  ██║██╔═══██╗╚══██╔══╝██╔════╝
# ██║   ██║██╔██╗ ██║█████╗  ██╔██╗ ██║██║   ██║   ██║   █████╗
# ██║   ██║██║╚██╗██║██╔══╝  ██║╚██╗██║██║   ██║   ██║   ██╔══╝
# ╚██████╔╝██║ ╚████║███████╗██║ ╚████║╚██████╔╝   ██║   ███████╗
#  ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═══╝ ╚═════╝    ╚═╝   ╚══════╝
{ pkgs, ... }:
{
  # Create a wrapper script for OneNote Web
  home.packages = with pkgs; [
    (writeScriptBin "onenote" ''
      #!${pkgs.bash}/bin/bash
      ${pkgs.chromium}/bin/chromium \
        --app=https://www.office.com/launch/onenote \
        --class=onenote-web
    '')
  ];

  # Create desktop entry for Wofi integration
  xdg.desktopEntries.onenote = {
    name = "OneNote";
    genericName = "Note Taking";
    exec = "onenote";
    icon = "onenote";
    categories = [ "Office" "TextEditor" ];
    type = "Application";
  };

  # Add icon for the application
  home.file.".local/share/icons/onenote.png".source = pkgs.fetchurl {
    url = "https://www.onenote.com/pwa/icon.png";
    sha256 = "02n6dcjligrk0521dqr94pqjfbjclfqsvl9bfg1iml72bwqapkih";
  };
}
