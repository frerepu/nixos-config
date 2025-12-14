# ██╗  ██╗ ██████╗ ███████╗████████╗███████╗     ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ ██████╗ ███╗   ██╗
# ██║  ██║██╔═══██╗██╔════╝╚══██╔══╝██╔════╝    ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔═══██╗████╗  ██║
# ███████║██║   ██║███████╗   ██║   ███████╗    ██║     ██║   ██║██╔████╔██║██╔████╔██║██║   ██║██╔██╗ ██║
# ██╔══██║██║   ██║╚════██║   ██║   ╚════██║    ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██║   ██║██║╚██╗██║
# ██║  ██║╚██████╔╝███████║   ██║   ███████║    ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║╚██████╔╝██║ ╚████║
# ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   ╚══════╝     ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
#
# Common base configuration shared across all hosts
# Includes networking, base packages, fonts, and common services

{ config, pkgs, ... }: {
  # Common base configuration
  imports = [ ];  # We'll move hardware-specific imports to host configs

  # Agenix secrets configuration
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  age.secrets.tailscale-authkey = {
    file = ../../secrets/tailscale-authkey.age;
  };
  age.secrets.spotify-username = {
    file = ../../secrets/spotify-username.age;
    mode = "444";  # World-readable as it's not sensitive
    owner = "faelterman";
  };

  # System-wide settings
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Common networking setup
  networking.networkmanager.enable = true;
  networking.useNetworkd = true;
  networking.useDHCP = false;
  services.resolved.enable = true;

  # Locale and time
  time.timeZone = "Europe/Brussels";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_BE.UTF-8";
    LC_IDENTIFICATION = "nl_BE.UTF-8";
    LC_MEASUREMENT = "nl_BE.UTF-8";
    LC_MONETARY = "nl_BE.UTF-8";
    LC_NAME = "nl_BE.UTF-8";
    LC_NUMERIC = "nl_BE.UTF-8";
    LC_PAPER = "nl_BE.UTF-8";
    LC_TELEPHONE = "nl_BE.UTF-8";
    LC_TIME = "nl_BE.UTF-8";
  };

  # Common system configuration
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings = {
    download-buffer-size = 256 * 1024 * 1024; # 256MB
    # You can also add other useful settings while you're at it:
    max-jobs = "auto";
    cores = 0; # Use all available cores

    # Binary caches for faster builds
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };


  # Base system packages
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    tailscale
    zsh
    wtype  # Wayland text input tool for typing from Companion

  ];

  # Common services
  services.tailscale = {
    enable = true;
    openFirewall = true;
    authKeyFile = config.age.secrets.tailscale-authkey.path;
    useRoutingFeatures = "both";
    #interfaceName = "userspace-networking";
    extraUpFlags = [
      "--advertise-exit-node"
      "--advertise-routes=172.16.10.0/24"
      "--accept-routes"  # Add this line
    ];
  };

  # USB auto-mount and file manager support
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-volman
  ];

  services.openssh.enable = true;

  # Common fonts
  fonts.packages = with pkgs; [
    cascadia-code
    font-awesome
    nerd-fonts.jetbrains-mono
    nerd-fonts.droid-sans-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    dejavu_fonts
  ];

  # Base firewall configuration
  networking.firewall = {
    enable = true;
    allowPing = true;
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
    allowedTCPPorts = [ 22 ];
  };

  # Base user configuration
  users.users.faelterman = {
    isNormalUser = true;
    description = "Frederic Aelterman";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  system.stateVersion = "24.11";
}
