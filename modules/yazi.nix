# ██╗   ██╗ █████╗ ███████╗██╗
# ╚██╗ ██╔╝██╔══██╗╚══███╔╝██║
#  ╚████╔╝ ███████║  ███╔╝ ██║
#   ╚██╔╝  ██╔══██║ ███╔╝  ██║
#    ██║   ██║  ██║███████╗██║
#    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝
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
      show_hidden = true;
      show_symlink = true;
      scrolloff = 5;
      mouse_events = [ "click" "scroll" ];
    };
  };

  # Create yazi.toml with correct TOML syntax
  xdg.configFile."yazi/yazi.toml".text = ''
    [opener]
    text = [
      { exec = '''kitty -e nvim "$@"''', block = true }
    ]

    [preview]
    terminal = "kitty"
  '';

  # Theme configuration remains the same
  xdg.configFile."yazi/theme.toml" = lib.mkForce {
    text = ''
      # Yazi theme configuration
      [manager]
      cwd = { fg = "#94e2d5" }
      hovered = { fg = "#1e1e2e", bg = "#cba6f7" }
      preview_hovered = { fg = "#1e1e2e", bg = "#cdd6f4" }
    '';
  };

  xdg.configFile."yazi/keymap.toml".text = ''
    [manager]
    # Add your keybindings here if needed
  '';

  xdg.desktopEntries.yazi = {
    name = "Yazi";
    comment = "Terminal file manager";
    terminal = false;  # Changed this to false
    exec = "kitty -e yazi";
    categories = [ "System" "FileManager" ];
    type = "Application";
  };
}