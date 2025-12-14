# ███████╗███████╗██╗  ██╗
# ╚══███╔╝██╔════╝██║  ██║
#   ███╔╝ ███████╗███████║
#  ███╔╝  ╚════██║██╔══██║
# ███████╗███████║██║  ██║
# ╚══════╝╚══════╝╚═╝  ╚═╝
{ config, pkgs, ... }:
let
  personal = import ../personal.nix;
in
{
  programs.zsh = {
    enable = true;
    shellAliases = personal.shellAliases;
    initExtra = ''
      eval "$(starship init zsh)"
    '';
    envExtra = ''
      # Suppress Starship error messages in non-interactive sessions
      if [[ "$TERM" == "dumb" ]] || [[ ! -t 0 && ! -t 1 ]]; then
        export STARSHIP_LOG=error
      fi
    '';
  };
}