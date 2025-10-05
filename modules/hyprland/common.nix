{ lib, pkgs, ... }: {
  # Common Hyprland configuration shared across all hosts
  # Host-specific settings (monitors, input devices) should be in host-specific configs

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Common environment variables
      env = [
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ];

      # Common input settings (can be overridden by host-specific)
      input = {
        kb_layout = lib.mkDefault "be";
        kb_variant = lib.mkDefault "";
        kb_model = lib.mkDefault "";
        kb_options = lib.mkDefault "";
        kb_rules = lib.mkDefault "";
        follow_mouse = lib.mkDefault 1;
        sensitivity = lib.mkDefault 0;
      };

      # Common general settings (can be overridden by host-specific)
      general = {
        gaps_in = lib.mkDefault 5;
        gaps_out = lib.mkDefault 20;
        border_size = lib.mkDefault 2;
        "col.active_border" = lib.mkDefault "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = lib.mkDefault "rgba(595959aa)";
        layout = lib.mkDefault "dwindle";
        allow_tearing = lib.mkDefault false;
      };

      # Common decoration settings (can be overridden by host-specific)
      decoration = {
        rounding = lib.mkDefault 10;
        blur = {
          enabled = lib.mkDefault true;
          size = lib.mkDefault 3;
          passes = lib.mkDefault 1;
        };
        drop_shadow = lib.mkDefault true;
        shadow_range = lib.mkDefault 4;
        shadow_render_power = lib.mkDefault 3;
        "col.shadow" = lib.mkDefault "rgba(1a1a1aee)";
      };

      # Common animations (can be overridden by host-specific)
      animations = {
        enabled = true;
      };

      # Common layout settings (can be overridden by host-specific)
      dwindle = {
        pseudotile = lib.mkDefault true;
        preserve_split = lib.mkDefault true;
      };

      master = {
        new_is_master = lib.mkDefault true;
      };

      # Common gestures (can be overridden for laptops)
      gestures = {
        workspace_swipe = lib.mkDefault false;
      };

      # Common miscellaneous settings (can be overridden by host-specific)
      misc = {
        force_default_wallpaper = lib.mkDefault (-1);
      };

      # Universal keybindings - these apply to all hosts
      "$mainMod" = "SUPER";

      bind = [
        # Application shortcuts
        "$mainMod, Q, exec, kitty"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, nemo"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, wofi --show drun"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Screenshot
        "$mainMod, Print, exec, hyprshot -m region"
        "SHIFT, Print, exec, hyprshot -m output"

        # Lock screen
        "$mainMod, L, exec, hyprlock"

        # Audio controls (universal)
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Common window rules
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "float, class:^(pavucontrol)$"
        "float, class:^(file_progress)$"
        "float, class:^(confirm)$"
        "float, class:^(dialog)$"
        "float, class:^(download)$"
        "float, class:^(notification)$"
        "float, class:^(error)$"
        "float, class:^(confirmreset)$"
        "float, title:^(Open File)$"
        "float, title:^(branchdialog)$"
        "float, title:^(Confirm to replace files)$"
        "float, title:^(File Operation Progress)$"
      ];
    };
  };
}