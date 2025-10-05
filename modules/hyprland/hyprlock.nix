# ██╗  ██╗██╗   ██╗██████╗ ██████╗ ██╗      ██████╗  ██████╗██╗  ██╗
# ██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗██║     ██╔═══██╗██╔════╝██║ ██╔╝
# ███████║ ╚████╔╝ ██████╔╝██████╔╝██║     ██║   ██║██║     █████╔╝ 
# ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██╗██║     ██║   ██║██║     ██╔═██╗ 
# ██║  ██║   ██║   ██║     ██║  ██║███████╗╚██████╔╝╚██████╗██║  ██╗
# ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝
{ 
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        grace = 0;
        no_fade_in = false;
        no_fade_out = true;
        ignore_empty_password = false;
        # No max_attempts setting, use default
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
        fade_on_empty = false;
        fade_timeout = 0;
        placeholder_text = "󰌾 Password";
        hide_input = false;
        check_color = "rgba(203, 166, 247, 1.0)";
        fail_color = "rgba(243, 139, 168, 1.0)";
        fail_text = "Mo gie Wost!";  # Simple text without any formatting to avoid variable expansion
        capslock_color = "rgba(249, 226, 175, 1.0)";
        position = "0, -47";
        halign = "center";
        valign = "center";
      }];
    };
  };
}