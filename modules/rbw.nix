{ pkgs, ... }:
#let
 # secrets = import ../secrets.nix;
#in
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
}