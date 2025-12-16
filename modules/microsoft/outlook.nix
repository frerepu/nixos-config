#  ██████╗ ██╗   ██╗████████╗██╗      ██████╗  ██████╗ ██╗  ██╗
# ██╔═══██╗██║   ██║╚══██╔══╝██║     ██╔═══██╗██╔═══██╗██║ ██╔╝
# ██║   ██║██║   ██║   ██║   ██║     ██║   ██║██║   ██║█████╔╝ 
# ██║   ██║██║   ██║   ██║   ██║     ██║   ██║██║   ██║██╔═██╗ 
# ╚██████╔╝╚██████╔╝   ██║   ███████╗╚██████╔╝╚██████╔╝██║  ██╗
#  ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝
{ pkgs, ... }:
{
  # Create a wrapper script for Outlook Web
  home.packages = with pkgs; [
    (writeScriptBin "outlook" ''
      #!${pkgs.bash}/bin/bash
      ${pkgs.chromium}/bin/chromium \
        --user-data-dir="$HOME/.config/chromium-outlook" \
        --app=https://outlook.office.com/mail/ \
        --class=outlook-web
    '')
  ];

  # Create desktop entry for Wofi integration
  xdg.desktopEntries.outlook = {
    name = "Outlook";
    genericName = "Email Client";
    exec = "outlook";
    icon = "outlook";
    categories = [ "Network" "Email" ];
    type = "Application";
  };

  # Add icon for the application
  home.file.".local/share/icons/hicolor/256x256/apps/outlook.png".source = pkgs.fetchurl {
    url = "https://outlook.office.com/mail/pwa/icon.png";
    sha256 = "19g6h0mhjw95c4gwk47ag2ydxkkkxyall72zxa26p0nhkx87v079";
  };
}