# ██████╗ ██╗███╗   ██╗██████╗ ███████╗
# ██╔══██╗██║████╗  ██║██╔══██╗██╔════╝
# ██████╔╝██║██╔██╗ ██║██║  ██║███████╗
# ██╔══██╗██║██║╚██╗██║██║  ██║╚════██║
# ██████╔╝██║██║ ╚████║██████╔╝███████║
# ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝



{lib, pkgs, ...}:{

  wayland.windowManager.hyprland.settings = {
    bind = [

      "$mainMod, Return, exec, $terminal"
      "$mainMod, C, killactive, "
      "$mainMod, M, exit,"
      "$mainMod, E, exec, $filemanager"
      "$mainMod, B, exec, $browser"
      "$mainMod, F, togglefloating,"
      "$mainMod, SPACE, exec, $menu"
      "$mainMod, P, pseudo," # dwindle
      "$mainMod, J, togglesplit," # dwindle
      "$mainMod SHIFT, E, exec, bemoji -cn"
      "$mainMod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
      "$mainMod, L, exec, hyprlock"
      "$mainMod, escape, exec, wlogout"
      "$mainMod SHIFT, P, exec, hyprpicker -an"
      "$mainMod, N, exec, swaync-client -t"
      " , Print, exec, hyprshot -m window"
      "SHIFT, Print, exec, hyprshot -m region"

      # Moving focus
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      # Moving windows
      "$mainMod SHIFT, left,  swapwindow, l"
      "$mainMod SHIFT, right, swapwindow, r"
      "$mainMod SHIFT, up,    swapwindow, u"
      "$mainMod SHIFT, down,  swapwindow, d"

      # Resizeing windows                   X  Y
      "$mainMod CTRL, left,  resizeactive, -60 0"
      "$mainMod CTRL, right, resizeactive,  60 0"
      "$mainMod CTRL, up,    resizeactive,  0 -60"
      "$mainMod CTRL, down,  resizeactive,  0  60"

      # Switching workspaces
      "$mainMod, ampersand, workspace, 1"
      "$mainMod, eacute, workspace, 2"
      "$mainMod, quotedbl, workspace, 3"
      "$mainMod, apostrophe, workspace, 4"
      "$mainMod, parenleft, workspace, 5"
      "$mainMod, section, workspace, 6"
      "$mainMod, egrave, workspace, 7"
      "$mainMod, exclam, workspace, 8"
      "$mainMod, ccedilla, workspace, 9"
      "$mainMod, agrave, workspace, 10"

      # Moving windows to workspaces SILENT !
      "$mainMod SHIFT, ampersand, movetoworkspacesilent, 1"
      "$mainMod SHIFT, eacute, movetoworkspacesilent, 2"
      "$mainMod SHIFT, quotedbl, movetoworkspacesilent, 3"
      "$mainMod SHIFT, apostrophe, movetoworkspacesilent, 4"
      "$mainMod SHIFT, parenleft, movetoworkspacesilent, 5"
      "$mainMod SHIFT, section, movetoworkspacesilent, 6"
      "$mainMod SHIFT, egrave, movetoworkspacesilent, 7"
      "$mainMod SHIFT, exclam, movetoworkspacesilent, 8"
      "$mainMod SHIFT, ccedilla, movetoworkspacesilent, 9"
      "$mainMod SHIFT, agrave, movetoworkspacesilent, 10"

      # Moving windows to workspaces
      "$mainMod SHIFT CTRL, ampersand, movetoworkspace, 1"
      "$mainMod SHIFT CTRL, eacute, movetoworkspace, 2"
      "$mainMod SHIFT CTRL, quotedbl, movetoworkspace, 3"
      "$mainMod SHIFT CTRL, apostrophe, movetoworkspace, 4"
      "$mainMod SHIFT CTRL, parenleft, movetoworkspace, 5"
      "$mainMod SHIFT CTRL, section, movetoworkspace, 6"
      "$mainMod SHIFT CTRL, egrave, movetoworkspace, 7"
      "$mainMod SHIFT CTRL, exclam, movetoworkspace, 8"
      "$mainMod SHIFT CTRL, ccedilla, movetoworkspace, 9"
      "$mainMod SHIFT CTRL, agrave, movetoworkspace, 10"


      # Scratchpad
      "$mainMod, S, togglespecialworkspace,  magic"
      "$mainMod SHIFT, S, movetoworkspace, special:magic"

      # Scroll through existing workspaces with mainMod + scroll
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"
    ];

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    # Laptop multimedia keys for volume and LCD brightness
    bindel = [
      ",XF86AudioRaiseVolume,  exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute,      exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      "$mainMod, bracketright, exec, brightnessctl s 10%+"
      "$mainMod, bracketleft,  exec, brightnessctl s 10%-"
    ];

    # Audio playback
    bindl = [
      ", XF86AudioNext,  exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay,  exec, playerctl play-pause"
      ", XF86AudioPrev,  exec, playerctl previous"
    ];
  };
}
