{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        grace = 0;
        no_fade_in = false;
        ignore_empty_password = false;
        max_attempts = 5;  # Set maximum attempts to 5
      };
      
      background = [{
        monitor = "";
        path = "$HOME/.config/background/wallhaven-8x16mo.png";
        blur_passes = 2;
        color = "rgb(30, 30, 46)";
      }];
      
      label = [
        {
          monitor = "";
          text = "$TIME";
          color = "rgba(235, 219, 178, 1.0)";
          font_size = 90;
          font_family = "JetBrainsMono Nerd Font";
          position = "-30, 0";
          halign = "right";
          valign = "top";
        }
        {
          monitor = "";
          text = "cmd[update:43200000] date +\"%A, %d %B %Y\"";
          color = "rgba(235, 219, 178, 1.0)";
          font_size = 25;
          font_family = "JetBrainsMono Nerd Font";
          position = "-30, -150";
          halign = "right";
          valign = "top";
        }
      ];
      
      image = [{
        monitor = "";
        path = "$HOME/.face";
        size = 100;
        border_color = "rgba(203, 166, 247, 1.0)";
        position = "0, 75";
        halign = "center";
        valign = "center";
      }];
      
      input-field = [{
        monitor = "";
        size = "300, 60";
        outline_thickness = 4;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "rgba(203, 166, 247, 1.0)";
        inner_color = "rgb(40, 40, 40)";
        font_color = "rgba(235, 219, 178, 1.0)";
        fade_on_empty = true;
        placeholder_text = "<span foreground=\"#999999\"><i>󰌾 Password </i></span>";
        hide_input = false;
        check_color = "rgba(203, 166, 247, 1.0)";
        fail_color = "rgba(243, 139, 168, 1.0)";
        fail_text = "";  # Empty fail text to avoid any counter display
        capslock_color = "rgba(249, 226, 175, 1.0)";
        position = "0, -47";
        halign = "center";
        valign = "center";
      }];
      
      # Add a permanent label for the fail message instead
      label = [
        # Fail message label (always visible)
        {
          monitor = "";
          text = "Mo gie Wost!";
          color = "rgba(243, 139, 168, 1.0)";  # Using fail color
          font_size = 18;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, -15";
          halign = "center";
          valign = "center";
          # Make this label only visible during failed attempts
          visibility = "if_no_input";  # This might not work but worth trying
        }
      ];
    };
  };
}