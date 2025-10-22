# ███╗   ███╗██████╗ ██████╗  ██╗███████╗
# ████╗ ████║██╔══██╗██╔══██╗███║██╔════╝
# ██╔████╔██║██████╔╝██████╔╝╚██║███████╗
# ██║╚██╔╝██║██╔══██╗██╔═══╝  ██║╚════██║
# ██║ ╚═╝ ██║██████╔╝██║      ██║███████║
# ╚═╝     ╚═╝╚═════╝ ╚═╝      ╚═╝╚══════╝
#
# MacBook Pro 15" host configuration
# Laptop-specific settings: power management, touchpad, brightness

{ config, pkgs, inputs, ... }: {
  imports = [
    ./hardware.nix
    ../common/desktop.nix
  ];

  # Host-specific configuration
  networking.hostName = "mbp15";

  # MacBook Pro uses NetworkManager for WiFi (enabled in common)

  # MacBook Pro specific packages
  environment.systemPackages = with pkgs; [
    # Power management tools
    tlp
    powertop
    acpi

    # Brightness control
    brightnessctl
  ];

  # Power management for MacBook Pro
  services.tlp = {
    enable = true;
    settings = {
      TLP_DEFAULT_MODE = "BAT";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      START_CHARGE_THRESH_BAT0 = 20;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  # Laptop-specific input configuration
  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = true;
      clickMethod = "clickfinger";
      accelProfile = "adaptive";
    };
  };
}
