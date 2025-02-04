{ config, pkgs, ... }:
let
  myAliases = {
    # You can add your own shell aliases here.
    ll = "ls -l";
    ".." = "cd ..";
    c = "clear";
    ls = "ls -lah --color=auto";
  };
  system = "x86_64-linux";
in
{
  home.username = "faelterman";
  home.homeDirectory = "/home/faelterman";
  home.stateVersion = "24.11";

  #xsession.numlock.enable = true;
  imports = [
    ./starship/starship.nix
  ];




  home.packages = with pkgs; [
    git
    pciutils
    teams-for-linux
    fastfetch
    kitty
    chromium
    wev
    wofi
    hyprpaper
    hyprlock
    hypridle
    hyprshot
    libnotify
    swaynotificationcenter
    nwg-look
    catppuccin
    waybar
    zed-editor
    (vscode-with-extensions.override {
    vscodeExtensions = with vscode-extensions; [
      bbenoist.nix
      esbenp.prettier-vscode
      ms-python.python
      tailscale.vscode-tailscale
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-ssh
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "remote-ssh-edit";
        publisher = "ms-vscode-remote";
        version = "0.47.2";
        sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
      }
    ];
  })
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    oh-my-posh
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
    # EDITOR = "emacs";
  };



  programs.git ={
    enable = true;
    userName = "frerepu";
    userEmail = "frederic@republiekbrugge.be";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  programs.bash = {
    enable = true;
    shellAliases = myAliases;
    bashrcExtra = ''
      eval "$(starship init bash)"
    '';
  };

  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
  };



  catppuccin.enable = true;

  home.pointerCursor = {
     gtk.enable = true;
     # x11.enable = true;
     package = pkgs.bibata-cursors;
     name = "Bibata-Modern-Classic";
     size = 16;
   };

   gtk = {
     enable = true;

     theme = {
       package = pkgs.flat-remix-gtk;
       name = "Flat-Remix-GTK-Grey-Darkest";
     };

     iconTheme = {
       package = pkgs.gnome.adwaita-icon-theme;
       name = "Adwaita";
     };

     font = {
       name = "JetBrainsMono";
       size = 11;
     };
   };





  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
