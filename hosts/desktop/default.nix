{ config, pkgs, ... }: {
  imports = [
    # ./hardware.nix  # Machine-specific hardware config
  ];

  networking.hostName = "nixos";
  networking.interfaces.enp4s0f0.useDHCP = true;

  # Desktop-specific services
  services.xserver = {
    enable = true;
    displayManager = {
      gdm.enable = false;
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "catppuccin-mocha";
        package = pkgs.kdePackages.sddm;
      };
      defaultSession = "hyprland";
    };

    xkb = {
      layout = "be";
      variant = "nodeadkeys";
    };
  };

  # Desktop-specific hardware configuration
  console.keyMap = "be-latin1";
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Desktop-specific programs
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  
  security.pam.services.hyprlock = {};
  
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  # Desktop-specific session management
  systemd.user.targets.hyprland-session = {
    description = "Hyprland compositor session";
    documentation = ["man:systemd.special(7)"];
    bindsTo = ["graphical-session.target"];
    wants = ["graphical-session-pre.target"];
    after = ["graphical-session-pre.target"];
  };

  services.xserver.displayManager.sessionPackages = [ pkgs.hyprland ];

  # Desktop-specific environment variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  environment.pathsToLink = [ "/share/wayland-sessions" ];

  # Desktop-specific activation scripts
  system.activationScripts = {
    sddm-session = {
      text = ''
        mkdir -p /usr/share/wayland-sessions
        ln -sfn ${pkgs.hyprland}/share/wayland-sessions/hyprland.desktop /usr/share/wayland-sessions/
      '';
      deps = [];
    };
  };
}