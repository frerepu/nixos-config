{ pkgs, ... }: {
  # Desktop-specific Hyprland configuration
  # This file contains overrides and additions specific to the desktop setup

  wayland.windowManager.hyprland.settings = {
    # Desktop monitor configuration
    monitor = [
      # Your actual monitor is eDP-1 with 4K resolution
      "eDP-1,3840x2160@60,0x0,1.5"  # Better scaling for 4K display
      # Add additional monitors as needed
      # "HDMI-A-1,1920x1080@60,3840x0,1"
      ",preferred,auto,1" # Fallback for any other monitors
    ];

    # Desktop-specific input (if you have special peripherals)
    input = {
      # Desktop mouse settings - no acceleration needed for desktop mouse
      accel_profile = "flat";
      force_no_accel = true;

      # Desktop keyboard settings
      repeat_rate = 25;
      repeat_delay = 600;
    };

    # Desktop can handle more intensive effects
    decoration = {
      blur = {
        enabled = true;
        size = 8;
        passes = 2;
        new_optimizations = true;
      };
      shadow = {
        enabled = true;
        range = 6;
        render_power = 3;
      };
    };

    # More intensive animations for desktop (since it has more power)
    animations = {
      enabled = true;
      bezier = [
        "overshot, 0.05, 0.9, 0.1, 1.05"
        "smoothOut, 0.36, 0, 0.66, -0.56"
        "smoothIn, 0.25, 1, 0.5, 1"
      ];
      animation = [
        "windows, 1, 5, overshot, slide"
        "windowsOut, 1, 4, smoothOut, slide"
        "windowsMove, 1, 4, default"
        "border, 1, 10, default"
        "fade, 1, 10, smoothIn"
        "fadeDim, 1, 10, smoothIn"
        "workspaces, 1, 6, default"
      ];
    };

    # Desktop-specific keybindings
    bind = [
      # Desktop-specific shortcuts (example: external monitor controls)
      "$mainMod SHIFT, M, exec, hyprctl keyword monitor DP-1,disable"
      "$mainMod CTRL, M, exec, hyprctl keyword monitor DP-1,2560x1440@144,0x0,1"

      # Brightness control for external monitors (if supported)
      # Uncomment and adjust if you have supported external monitors
      # ", XF86MonBrightnessUp, exec, ddcutil setvcp 10 + 10"
      # ", XF86MonBrightnessDown, exec, ddcutil setvcp 10 - 10"
    ];

    # Desktop-specific window rules (for multi-monitor setup)
    windowrulev2 = [
      # Example: Force certain apps to specific monitors
      # "workspace 1, class:^(firefox)$"
      # "workspace 2, class:^(code)$"
    ];

    # Workspace assignment for multi-monitor (if applicable)
    workspace = [
      # Example workspace-to-monitor assignments
      # "1, monitor:DP-1"
      # "2, monitor:HDMI-A-1"
    ];
  };
}