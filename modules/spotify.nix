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
    spotify-player  # Terminal UI with full feature parity
  ];

  # Spotifyd daemon for headless playback control
  # Username managed by agenix, password by rbw
  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        username_cmd = "cat /run/agenix/spotify-username";  # Get username from agenix
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
}
