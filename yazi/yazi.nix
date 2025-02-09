{ pkgs, lib, ... }:
{
  programs.yazi = {
    enable = true;

    settings = {
      ratio = [ 1 4 6 ];
      sort_by = "alphabetical";
      sort_sensitive = false;
      sort_reverse = false;
      sort_dir_first = true;
      sort_translit = false;
      linemode = "none";
      show_hidden = false;
      show_symlink = true;
      scrolloff = 5;
      mouse_events = [ "click" "scroll" ];
    };
  };

  # Explicitly set our theme configuration with high priority
  xdg.configFile."yazi/theme.toml" = lib.mkForce {
    text = ''
      # Yazi theme configuration
      [manager]
      cwd = { fg = "#94e2d5" }

      hovered = { fg = "#1e1e2e", bg = "#cba6f7" }
      preview_hovered = { fg = "#1e1e2e", bg = "#cdd6f4" }

      # ... rest of your theme configuration in TOML format
    '';
  };

  # Basic keymap configuration
  xdg.configFile."yazi/keymap.toml".text = ''
    [manager]
    # Add your keybindings here if needed
  '';
}