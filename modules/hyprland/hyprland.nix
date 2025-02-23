{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      env = [
        # Hint Electron apps to use Wayland
        "NIXOS_OZONE_WL,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORM,wayland"
        "XDG_SCREENSHOTS_DIR,$HOME/screens"
      ];

      monitor=eDP-1,3840x2160,auto,1.6
      $terminal = kitty
      $browser = zen browser
      $fileManager = thunar
      $menu = wofi --show drun


      exec-once = [
        "waybar"
        "swaync"
        "hypridle"
        "hyprpaper"
        "systemctl --user start hyprpolkitagent"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      general = {
        gaps_in = 0;
        gaps_out = 0;

        border_size = 2;
       
        col.active_border = "rgba(6c63ffee) rgba(fab387ee) 70deg";
        col.inactive_border = "rgba(595959aa)";

        resize_on_border = true;

        allow_tearing = false;

        layout = "master"; #"dwindle";
      };

      decoration = {
        rounding = 0;

        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = false;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
        bezier = "easeOutQuint,0.23,1,0.32,1";
        bezier = "easeInOutCubic,0.65,0.05,0.36,1";
        bezier = "linear,0,0,1,1";
        bezier = "almostLinear,0.5,0.5,0.75,1.0";
        bezier = "quick,0.15,0,0.1,1";
        animation = "global, 1, 10, default";
        animation = "border, 1, 5.39, easeOutQuint";
        animation = "windows, 1, 4.79, easeOutQuint";
        animation = "windowsIn, 1, 4.1, easeOutQuint, popin 87%";
        animation = "windowsOut, 1, 1.49, linear, popin 87%";
        animation = "fadeIn, 1, 1.73, almostLinear";
        animation = "fadeOut, 1, 1.46, almostLinear";
        animation = "fade, 1, 3.03, quick";
        animation = "layers, 1, 3.81, easeOutQuint";
        animation = "layersIn, 1, 4, easeOutQuint, fade";
        animation = "layersOut, 1, 1.5, linear, fade";
        animation = "fadeLayersIn, 1, 1.79, almostLinear";
        animation = "fadeLayersOut, 1, 1.39, almostLinear";
        animation = "workspaces, 1, 1.94, almostLinear, fade";
        animation = "workspacesIn, 1, 1.21, almostLinear, fade";
        animation = "workspacesOut, 1, 1.94, almostLinear, fade";
      };

      input = {
        kb_layout = "be";
        follow_mouse = 1
      };

      device {
       name = epic-mouse-v1;
       sensitivity = -0.5;
     };


      gestures = {
        workspace_swipe = true;
        workspace_swipe_invert = false;
        workspace_swipe_forever	= true;

      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
        new_on_top = true;
        mfact = 0.5;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      windowrulev2 = [
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        float,class:(clipse) # ensure you have a floating window class set if you want this behavior
        size 622 652,class:(clipse) # set the size of the window as necessary

        # "bordersize 0, floating:0, onworkspace:w[t1]"
        # "float,class:(mpv)|(imv)|(showmethekey-gtk)"
        # "move 990 60,size 900 170,pin,noinitialfocus,class:(showmethekey-gtk)"
        # "noborder,nofocus,class:(showmethekey-gtk)"
        # "workspace 3,class:(obsidian)"
        # "workspace 3,class:(zathura)"
        # "workspace 4,class:(com.obsproject.Studio)"
        # "workspace 5,class:(telegram)"
        # "workspace 5,class:(vesktop)"
        # "workspace 6,class:(teams-for-linux)"
        # "suppressevent maximize, class:.*"
        # "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        # "opacity 0.0 override, class:^(xwaylandvideobridge)$"
        # "noanim, class:^(xwaylandvideobridge)$"
        # "noinitialfocus, class:^(xwaylandvideobridge)$"
        # "maxsize 1 1, class:^(xwaylandvideobridge)$"
        # "noblur, class:^(xwaylandvideobridge)$"
        # "nofocus, class:^(xwaylandvideobridge)$"
      ];

    #   workspace = [
    #     "w[tv1], gapsout:0, gapsin:0"
    #     "f[1], gapsout:0, gapsin:0"
    #   ];
    };
  };
}