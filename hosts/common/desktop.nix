# ██████╗ ███████╗███████╗██╗  ██╗████████╗ ██████╗ ██████╗
# ██╔══██╗██╔════╝██╔════╝██║ ██╔╝╚══██╔══╝██╔═══██╗██╔══██╗
# ██║  ██║█████╗  ███████╗█████╔╝    ██║   ██║   ██║██████╔╝
# ██║  ██║██╔══╝  ╚════██║██╔═██╗    ██║   ██║   ██║██╔═══╝
# ██████╔╝███████╗███████║██║  ██╗   ██║   ╚██████╔╝██║
# ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝
#
# Shared desktop configuration for all graphical hosts
# This includes display managers, audio, Hyprland, and common desktop services

{ config, lib, pkgs, inputs, ... }: {
  # Shared desktop configuration for all graphical hosts
  # This includes display managers, audio, Hyprland, and common desktop services

  imports = [
    inputs.catppuccin.nixosModules.catppuccin
    #../../modules/sddm.nix
    ../../modules/greetd.nix
  ];

  # Desktop services
  services.flatpak.enable = true;
  services.onedrive.enable = true;

  # X11/Display server configuration
  services.xserver = {
    enable = true;
    xkb = {
      layout = "be";
      options = "";
    };
  };

  # Audio configuration
  console.keyMap = "be-latin1";
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Hyprland is configured via home-manager (modules/hyprland/)
  # Enable XWayland support system-wide
  programs.hyprland.enable = true;

  security.pam.services.hyprlock = {};

  # XDG Portal configuration
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  # Systemd session management
  systemd.user.targets.hyprland-session = {
    description = "Hyprland compositor session";
    documentation = ["man:systemd.special(7)"];
    bindsTo = ["graphical-session.target"];
    wants = ["graphical-session-pre.target"];
    after = ["graphical-session-pre.target"];
  };

  # Environment variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    EDITOR = "Visual Studio Code";
    BROWSER = "Zen Browser";
    TERMINAL = "kitty";
  };

  environment.pathsToLink = [ "/share/wayland-sessions" ];
}
