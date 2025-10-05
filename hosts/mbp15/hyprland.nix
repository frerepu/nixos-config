{ pkgs, ... }: {
  # MacBook Pro 15" specific Hyprland configuration
  # This file contains overrides and additions specific to the MacBook Pro setup

  wayland.windowManager.hyprland.settings = {
    # MacBook Pro monitor configuration
    monitor = [
      # Built-in MacBook Pro 15" display (adjust resolution to match your model)
      # Common MacBook Pro 15" resolutions:
      # - 2880x1800 (Retina)
      # - 2560x1600 (Retina)
      "eDP-1,2880x1800@60,0x0,1.5"  # Adjust resolution and scale as needed

      # External monitor support (when connected)
      ",preferred,auto,1"
    ];

    # MacBook Pro input configuration
    input = {
      # Trackpad settings
      touchpad = {
        natural_scroll = true;
        tap-to-click = true;
        disable_while_typing = true;
        clickfinger_behavior = true;
        middle_button_emulation = false;
        drag_lock = false;
      };

      # Keyboard settings for MacBook Pro
      kb_options = "caps:escape"; # Map caps lock to escape (popular on MacBooks)

      # Mouse acceleration for trackpad
      accel_profile = "adaptive";
      force_no_accel = false;
      sensitivity = 0.0;
    };

    # Power-efficient settings for laptop
    decoration = {
      # Lighter effects to save battery
      blur = {
        enabled = true;
        size = 3;
        passes = 1;
        new_optimizations = true;
      };
      drop_shadow = true;
      shadow_range = 4;
      shadow_render_power = 2;
    };

    # Battery-friendly animations
    animations = {
      enabled = true;
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      animation = [
        "windows, 1, 4, myBezier"
        "windowsOut, 1, 4, default, popin 80%"
        "border, 1, 6, default"
        "borderangle, 1, 6, default"
        "fade, 1, 4, default"
        "workspaces, 1, 4, default"
      ];
    };

    # Laptop-specific gestures
    gestures = {
      workspace_swipe = true;
      workspace_swipe_fingers = 3;
      workspace_swipe_distance = 300;
      workspace_swipe_invert = true;
      workspace_swipe_min_speed_to_force = 30;
      workspace_swipe_cancel_ratio = 0.5;
      workspace_swipe_create_new = true;
    };

    # MacBook Pro specific keybindings
    bind = [
      # Brightness controls (MacBook Pro function keys)
      ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
      ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"

      # MacBook Pro specific function keys
      ", XF86LaunchA, exec, wofi --show drun"  # Launchpad equivalent
      ", XF86LaunchB, exec, hyprctl dispatch workspace empty"  # Mission Control equivalent

      # Power management
      "$mainMod SHIFT, L, exec, systemctl suspend"
      "$mainMod SHIFT, P, exec, systemctl poweroff"

      # Lid close behavior is handled by systemd, but you can add custom actions
      # Display management for when connecting/disconnecting external monitors
      "$mainMod SHIFT, D, exec, hyprctl keyword monitor eDP-1,disable"  # Disable internal display
      "$mainMod CTRL, D, exec, hyprctl keyword monitor eDP-1,2880x1800@60,0x0,1.5"  # Re-enable internal display
    ];

    # MacBook Pro specific window rules
    windowrulev2 = [
      # Battery conservation: reduce opacity for background windows
      "opacity 0.9 0.9, focus:0"

      # Specific apps that work well on laptop screen
      "float, class:^(Calculator)$"
      "size 400 600, class:^(Calculator)$"
      "center, class:^(Calculator)$"
    ];

    # Workspace configuration optimized for single screen
    workspace = [
      # Keep workspaces on the main (internal) display
      "1, monitor:eDP-1, default:true"
      "2, monitor:eDP-1"
      "3, monitor:eDP-1"
      "4, monitor:eDP-1"
      "5, monitor:eDP-1"
    ];

    # MacBook Pro specific exec-once commands
    exec-once = [
      # Battery management
      "tlp start"

      # Laptop-specific startup apps
      "blueman-applet"  # Bluetooth management

      # Auto-adjust display based on ambient light (if supported)
      # "clight"
    ];
  };
}