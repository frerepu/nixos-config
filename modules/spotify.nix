# ███████╗██████╗  ██████╗ ████████╗██╗███████╗██╗   ██╗
# ██╔════╝██╔══██╗██╔═══██╗╚══██╔══╝██║██╔════╝╚██╗ ██╔╝
# ███████╗██████╔╝██║   ██║   ██║   ██║█████╗   ╚████╔╝
# ╚════██║██╔═══╝ ██║   ██║   ██║   ██║██╔══╝    ╚██╔╝
# ███████║██║     ╚██████╔╝   ██║   ██║██║        ██║
# ╚══════╝╚═╝      ╚═════╝    ╚═╝   ╚═╝╚═╝        ╚═╝
#
# Spotify music streaming client configuration

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    spotify
  ];

  # Optional: Enable Spotifyd daemon for headless playback control
  # Uncomment to enable:
  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        username = "1118565451";
        password_cmd = "rbw get spotify";  # Use rbw password manager
        backend = "pulseaudio";
        device_name = "NixOS Spotify";
        bitrate = 320;
        cache_path = "/home/faelterman/.cache/spotifyd";
        volume_normalisation = true;
        normalisation_pregain = -10;
      };
    };
  };

  # Optional: Add spotify-tui for terminal UI control
  home.packages = with pkgs; [
    spotify-tui
  ];
}
