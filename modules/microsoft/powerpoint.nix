# ██████╗  ██████╗ ██╗    ██╗███████╗██████╗ ██████╗  ██████╗ ██╗███╗   ██╗████████╗
# ██╔══██╗██╔═══██╗██║    ██║██╔════╝██╔══██╗██╔══██╗██╔═══██╗██║████╗  ██║╚══██╔══╝
# ██████╔╝██║   ██║██║ █╗ ██║█████╗  ██████╔╝██████╔╝██║   ██║██║██╔██╗ ██║   ██║
# ██╔═══╝ ██║   ██║██║███╗██║██╔══╝  ██╔══██╗██╔═══╝ ██║   ██║██║██║╚██╗██║   ██║
# ██║     ╚██████╔╝╚███╔███╔╝███████╗██║  ██║██║     ╚██████╔╝██║██║ ╚████║   ██║
# ╚═╝      ╚═════╝  ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝      ╚═════╝ ╚═╝╚═╝  ╚═══╝   ╚═╝
{ pkgs, ... }:
{
  # Create a wrapper script for PowerPoint Web
  home.packages = with pkgs; [
    (writeScriptBin "powerpoint" ''
      #!${pkgs.bash}/bin/bash
      ${pkgs.chromium}/bin/chromium \
        --app=https://www.office.com/launch/powerpoint \
        --class=powerpoint-web
    '')
  ];

  # Create desktop entry for Wofi integration
  xdg.desktopEntries.powerpoint = {
    name = "PowerPoint";
    genericName = "Presentation";
    exec = "powerpoint";
    icon = "powerpoint";
    categories = [ "Office" "Presentation" ];
    type = "Application";
  };

  # Add icon for the application
  home.file.".local/share/icons/powerpoint.png".source = pkgs.fetchurl {
    url = "https://powerpoint.office.com/pwa/icon.png";
    sha256 = "0p3kprnwrk81lpiysmj1ina1ww9hxa13hp8xp326fir9sxy9r1vy";
  };
}
