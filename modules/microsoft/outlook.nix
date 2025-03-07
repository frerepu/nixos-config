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
  home.file.".local/share/icons/outlook.png".source = pkgs.fetchurl {
    url = "https://outlook.office.com/mail/pwa/icon.png";
    sha256 = "068p7fd2qziivwajgdc8cn3px9m8jws57l87r6xmjbh63gwdbw9a"; # You'll need to replace this with the actual hash
  };
}