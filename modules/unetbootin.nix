# ██╗   ██╗███╗   ██╗███████╗████████╗██████╗  ██████╗  ██████╗ ████████╗██╗███╗   ██╗
# ██║   ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██╔═══██╗██╔═══██╗╚══██╔══╝██║████╗  ██║
# ██║   ██║██╔██╗ ██║█████╗     ██║   ██████╔╝██║   ██║██║   ██║   ██║   ██║██╔██╗ ██║
# ██║   ██║██║╚██╗██║██╔══╝     ██║   ██╔══██╗██║   ██║██║   ██║   ██║   ██║██║╚██╗██║
# ╚██████╔╝██║ ╚████║███████╗   ██║   ██████╔╝╚██████╔╝╚██████╔╝   ██║   ██║██║ ╚████║
#  ╚═════╝ ╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═════╝  ╚═════╝  ╚═════╝    ╚═╝   ╚═╝╚═╝  ╚═══╝
{ pkgs, ... }:
{
  # Create a wrapper script for UNetbootin with root privileges
  home.packages = with pkgs; [
    unetbootin
    (writeScriptBin "unetbootin-gui" ''
      #!${pkgs.bash}/bin/bash
      ${pkgs.polkit}/bin/pkexec ${pkgs.unetbootin}/bin/unetbootin
    '')
  ];

  # Create desktop entry for Wofi integration
  xdg.desktopEntries.unetbootin = {
    name = "UNetbootin";
    genericName = "USB Creator";
    exec = "unetbootin-gui";
    icon = "unetbootin";
    categories = [ "System" "Utility" ];
    type = "Application";
  };

  # Use a generic system icon for the application
  # UNetbootin doesn't have a publicly accessible icon URL
  # The system will fall back to a generic USB/drive icon
}
