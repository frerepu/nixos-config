{ lib, pkgs, ... }:

# ██╗  ██╗██╗   ██╗██████╗ ██████╗ ██╗      █████╗ ███╗   ██╗██████╗      ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ ██████╗ ███╗   ██╗
# ██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗██║     ██╔══██╗████╗  ██║██╔══██╗    ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔═══██╗████╗  ██║
# ███████║ ╚████╔╝ ██████╔╝██████╔╝██║     ███████║██╔██╗ ██║██║  ██║    ██║     ██║   ██║██╔████╔██║██╔████╔██║██║   ██║██╔██╗ ██║
# ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██╗██║     ██╔══██║██║╚██╗██║██║  ██║    ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██║   ██║██║╚██╗██║
# ██║  ██║   ██║   ██║     ██║  ██║███████╗██║  ██║██║ ╚████║██████╔╝    ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║╚██████╔╝██║ ╚████║
# ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
#
# Common Hyprland configuration shared across all hosts
# Host-specific settings (monitors, input devices) should be in host-specific configs

{

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
        gaps_in = lib.mkDefault 2;
        gaps_out = lib.mkDefault 2;
        border_size = lib.mkDefault 2;
        "col.active_border" = lib.mkDefault "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = lib.mkDefault "rgba(595959aa)";
        layout = lib.mkDefault "dwindle";
        allow_tearing = lib.mkDefault false;
      };

      # Common decoration settings (can be overridden by host-specific)
      decoration = {
        rounding = lib.mkDefault 8;
        blur = {
          enabled = lib.mkDefault true;
          size = lib.mkDefault 3;
          passes = lib.mkDefault 1;
        };
        shadow = {
          enabled = lib.mkDefault true;
          range = lib.mkDefault 4;
          render_power = lib.mkDefault 3;
          color = lib.mkDefault "rgba(1a1a1aee)";
        };
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
        new_status = lib.mkDefault "master";
      };

      # Gestures are handled by host-specific configs

      # Common miscellaneous settings (can be overridden by host-specific)
      misc = {
        force_default_wallpaper = lib.mkDefault (-1);
      };

      # Autostart applications
      exec-once = [
        "waybar"
        "swaync"
        "hypridle"
        "hyprpaper"
        "systemctl --user start hyprpolkitagent"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];
      # Add these variable definitions
        "$terminal" = "kitty";
        "$filemanger" = "thunar";
        "$menu" = "wofi --show drun";
        "$browser" = "flatpak run app.zen_browser.zen";
      # Universal keybindings are in binds.nix - imported via default.nix
        "$mainMod" = "SUPER";

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
