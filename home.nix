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
    ./modules/zsh.nix
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
    ./modules/whatsapp.nix
    ./modules/orca-slicer.nix
    ./modules/qt.nix
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

    # Theming
    (catppuccin-gtk.override {
      accents = [ "mauve" ];
      size = "standard";
      tweaks = [ "rimless" ];
      variant = "mocha";
    })
    hicolor-icon-theme
    gtk3
    glib

    # File managers
    kitty
    nemo-with-extensions

    # PDF and image viewers
    zathura
    imv

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
    GTK_THEME = "catppuccin-mocha-mauve-standard+rimless";
  };

  programs.bash = {
    enable = true;
    shellAliases = personal.shellAliases;
    bashrcExtra = ''
      eval "$(starship init bash)"
      fastfetch
    '';
  };
  home.pointerCursor = {
     gtk.enable = true;
     x11.enable = true;
     package = pkgs.bibata-cursors;
     name = "Bibata-Modern-Ice";
     size = 16;
   };

  gtk = {
    enable = true;
    font = {
        name = "JetBrainsMono";
        size = 11;
    };
    theme = {
      name = "catppuccin-mocha-mauve-standard+rimless";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "standard";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  # Enable dconf for GTK settings
  dconf.enable = true;

  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  catppuccin.accent = "mauve";

  # XDG MIME type associations
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # PDF viewer
      "application/pdf" = "org.pwmt.zathura.desktop";

      # Image viewer
      "image/png" = "imv.desktop";
      "image/jpeg" = "imv.desktop";
      "image/jpg" = "imv.desktop";
      "image/gif" = "imv.desktop";
      "image/webp" = "imv.desktop";
      "image/bmp" = "imv.desktop";
      "image/svg+xml" = "imv.desktop";
    };
  };

  # Force overwrite existing mimeapps.list files
  xdg.configFile."mimeapps.list".force = true;
  xdg.dataFile."applications/mimeapps.list".force = true;
}
