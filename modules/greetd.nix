{ config, pkgs, lib, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --user-menu --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  # Ensure greeter user has access to necessary resources
  environment.etc."greetd/environments".text = ''
    Hyprland
  '';

  # Clear screen before greetd starts
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}