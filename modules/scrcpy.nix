# ███████╗ ██████╗██████╗  ██████╗██████╗ ██╗   ██╗
# ██╔════╝██╔════╝██╔══██╗██╔════╝██╔══██╗╚██╗ ██╔╝
# ███████╗██║     ██████╔╝██║     ██████╔╝ ╚████╔╝
# ╚════██║██║     ██╔══██╗██║     ██╔═══╝   ╚██╔╝
# ███████║╚██████╗██║  ██║╚██████╗██║        ██║
# ╚══════╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝╚═╝        ╚═╝
#
# scrcpy - Display and control Android devices
# Enables screen mirroring and control over USB or wireless ADB connection
#
# References:
# - scrcpy: https://github.com/Genymobile/scrcpy
# - Documentation: https://github.com/Genymobile/scrcpy/blob/master/doc/README.md
# - Requires ADB (Android Debug Bridge) enabled on device

{ config, lib, pkgs, ... }:

{
  # Install scrcpy for Android device mirroring and control
  home.packages = with pkgs; [
    scrcpy           # Display and control Android devices
    android-tools    # Includes adb for device connection

    # Video acceleration libraries for hardware decoding (AMD/Intel/NVIDIA)
    libva            # VA-API support
    libva-utils      # VA-API utilities (vainfo for debugging)
    mesa             # Mesa VA-API drivers for AMD/Intel
    ffmpeg-full      # Full FFmpeg with all codecs
    mesa-demos       # OpenGL utilities (includes glxinfo)
  ];

  # Environment variables for video acceleration
  # AMD GPUs use radeonsi VA-API driver
  home.sessionVariables = {
    LIBVA_DRIVER_NAME = "radeonsi";  # AMD Radeon VA-API driver
    SDL_VIDEODRIVER = "wayland";      # Force Wayland for SDL2
  };

  # Shell aliases for scrcpy with optimal settings
  # Note: scrcpy 3.3.3 doesn't support config files yet, so we use aliases
  home.shellAliases = {
    scrcpy = "scrcpy --render-driver=opengles2 --video-codec=h264 --video-encoder=c2.android.avc.encoder --max-size=1080";
  };

  # Configure Hyprland window rules for scrcpy
  wayland.windowManager.hyprland = lib.mkIf config.wayland.windowManager.hyprland.enable {
    settings = {
      windowrulev2 = [
        # Match scrcpy windows by class and title (matches "scrcpy" or device name)
        "float, class:^(scrcpy)$"
        "float, title:^(SM-A536B)$"

        # Set window size (width x height) - half size
        "size 412 900, class:^(scrcpy)$"
        "size 396 880, title:^(SM-A536B)$"

        # Add transparency to scrcpy windows (90% opacity)
        "opacity 0.90 0.85, class:^(scrcpy)$"
        "opacity 0.90 0.85, title:^(SM-A536B)$"

        # Center the window
        "center, class:^(scrcpy)$"
        "center, title:^(SM-A536B)$"
      ];
    };
  };
}
