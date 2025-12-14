# ██╗  ██╗ ██████╗ ███╗   ███╗███████╗
# ██║  ██║██╔═══██╗████╗ ████║██╔════╝
# ███████║██║   ██║██╔████╔██║█████╗
# ██╔══██║██║   ██║██║╚██╔╝██║██╔══╝
# ██║  ██║╚██████╔╝██║ ╚═╝ ██║███████╗
# ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝
#
# Shared home-manager configuration
# Common user packages and settings across all hosts

{ config, pkgs, ... }:
let
  personal = import ./personal.nix;
in
{
  home = {
    username = "faelterman";
    homeDirectory = "/home/faelterman";
    stateVersion = "24.11";
  };
  imports = [
    ./modules/git.nix
    ./modules/starship.nix
    ./modules/wofi/wofi.nix
    ./modules/yazi.nix
    ./modules/bat.nix
    ./modules/rbw.nix
    ./modules/waybar/waybar.nix
    ./modules/microsoft
    ./modules/hyprland/default.nix
    ./modules/figlet.nix
    ./modules/mixingstation.nix
    ./modules/vscode.nix
    ./modules/unetbootin.nix
    ./modules/gnome-disks.nix
    ./modules/spotify.nix
  ];
  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
  services.figlet.enable = true;

  home.packages = with pkgs; [
    # System utilities
    pciutils
    fastfetch
    unzip
    btop
    tldr
    eza
    fzf
    zoxide
    wev
    libnotify
    
    # File managers
    kitty
    nemo-with-extensions
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman

    # Development tools
    nodejs_20
    claude-code
    zed-editor
    
    # Web browsers
    chromium

    # Communication
    teams-for-linux
    webcord
    mumble
    element-desktop

    # Hyprland ecosystem
    hyprpaper
    hyprpicker
    hyprsunset
    hyprpolkitagent
    hyprcursor
    hyprshot
    hyprls

    # Desktop utilities
    rofi-rbw-wayland
    swaynotificationcenter
    wlogout
    swayosd
    nwg-look
    cliphist
    wl-clipboard

    # Cloud storage
    onedrivegui

    # Theming
    catppuccin

    # 3D Printing
    orca-slicer
  ];



  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {

    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/faelterman/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    TERM = "xterm-kitty";
  };

  programs.bash = {
    enable = true;
    shellAliases = personal.shellAliases;
    bashrcExtra = ''
      eval "$(starship init bash)"
    '';
  };
  home.pointerCursor = {
     gtk.enable = true;
     x11.enable = true;
     package = pkgs.bibata-cursors;
     name = "Bibata-Modern-Ice";
     size = 10;
   };

  gtk = {
    enable = true;
    font = {
        name = "JetBrainsMono";
        size = 11;
    };
  };

  catppuccin.enable = true;
  catppuccin.gtk = {
    icon.enable = true;
  };
}
