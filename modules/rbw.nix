# ██████╗ ██████╗ ██╗    ██╗
# ██╔══██╗██╔══██╗██║    ██║
# ██████╔╝██████╔╝██║ █╗ ██║
# ██╔══██╗██╔══██╗██║███╗██║
# ██║  ██║██████╔╝╚███╔███╔╝
# ╚═╝  ╚═╝╚═════╝  ╚══╝╚══╝ 
{ pkgs, ... }:

let
  rbw-terminal = pkgs.writeShellScriptBin "rbw-terminal" ''
    # First, try to unlock rbw (will do nothing if already unlocked)
    ${pkgs.rbw}/bin/rbw unlock

    # Check if login is needed
    if ! ${pkgs.rbw}/bin/rbw status | grep -q "logged in"; then
      ${pkgs.rbw}/bin/rbw login
    fi

    # Launch kitty with rbw get command pre-filled
    ${pkgs.kitty}/bin/kitty --class="rbw-terminal" bash -c 'echo -n "rbw get " && read -e cmd && eval "$cmd"'
  '';

  rbw-desktop = pkgs.makeDesktopItem {
    name = "rbw";
    desktopName = "Bitwarden CLI";
    comment = "Unofficial Bitwarden CLI client";
    icon = "bitwarden";
    exec = "${rbw-terminal}/bin/rbw-terminal";
    categories = [ "Utility" "Security" ];
    terminal = false;
  };
in
{
  programs.rbw = {
    enable = true;
    settings = {
      email = "frederic.aelterman@gmail.com";
      base_url = "https://bitwarden.faelterman.be";
      lock_timeout = 86400;
      sync_interval = 600;
      pinentry = pkgs.pinentry-tty;
    };
  };

  home.packages = [
    rbw-terminal
    rbw-desktop
  ];

  xdg.enable = true;
}