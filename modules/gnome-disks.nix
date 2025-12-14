#  ██████╗ ███╗   ██╗ ██████╗ ███╗   ███╗███████╗    ██████╗ ██╗███████╗██╗  ██╗███████╗
# ██╔════╝ ████╗  ██║██╔═══██╗████╗ ████║██╔════╝    ██╔══██╗██║██╔════╝██║ ██╔╝██╔════╝
# ██║  ███╗██╔██╗ ██║██║   ██║██╔████╔██║█████╗      ██║  ██║██║███████╗█████╔╝ ███████╗
# ██║   ██║██║╚██╗██║██║   ██║██║╚██╔╝██║██╔══╝      ██║  ██║██║╚════██║██╔═██╗ ╚════██║
# ╚██████╔╝██║ ╚████║╚██████╔╝██║ ╚═╝ ██║███████╗    ██████╔╝██║███████║██║  ██╗███████║
#  ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝    ╚═════╝ ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝
{ pkgs, ... }:
{
  # Create a wrapper script for GNOME Disks with root privileges
  home.packages = with pkgs; [
    gnome-disk-utility
    (writeScriptBin "gnome-disks-gui" ''
      #!${pkgs.bash}/bin/bash
      /run/wrappers/bin/pkexec env \
        DISPLAY="$DISPLAY" \
        WAYLAND_DISPLAY="$WAYLAND_DISPLAY" \
        XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" \
        ${pkgs.gnome-disk-utility}/bin/gnome-disks
    '')
  ];

  # Create desktop entry for Wofi integration
  xdg.desktopEntries.gnome-disks = {
    name = "GNOME Disks";
    genericName = "Disk Utility";
    exec = "gnome-disks-gui";
    icon = "gnome-disks";
    categories = [ "System" "Utility" ];
    type = "Application";
  };

  # GNOME Disks uses the icon from the package itself
  # which is already available in the system icon theme
}
