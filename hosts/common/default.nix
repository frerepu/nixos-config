{ config, pkgs, ... }: {
  # Common base configuration
  imports = [ ];  # We'll move hardware-specific imports to host configs

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

  # Base system packages
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    tailscale
    zsh
  
  ];

  # Common services
  services.tailscale = {
    enable = true;
    openFirewall = true;
    authKeyFile = "/home/faelterman/secrets/tsauthkeyfile";
    useRoutingFeatures = "both";
    interfaceName = "userspace-networking";
    extraUpFlags = [
      "--advertise-exit-node" # if you want to use it as an exit node 
      "--advertise-routes=10.0.0.0/24,172.16.10.0/24" # if you want to advertise routes 
      # "--login-server=https://your-instance" # if you use a non-default tailscale coordinator
      # "--accept-dns=false" # if its' a server you prolly dont need magicdns
    ];
  };
  

  services.openssh.enable = true;

  # Common fonts
  fonts.packages = with pkgs; [
    cascadia-code
    font-awesome
    nerd-fonts.jetbrains-mono
    nerd-fonts.droid-sans-mono
  ];

  # Base firewall configuration
  networking.firewall = {
    enable = true;
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