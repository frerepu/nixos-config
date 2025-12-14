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
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    # Starship is automatically initialized via enableZshIntegration in starship.nix
    # No need to manually call eval "$(starship init zsh)"
    initContent = ''
      # Suppress Starship error messages in non-interactive sessions
      if [[ "$TERM" == "dumb" ]] || [[ ! -t 0 && ! -t 1 ]]; then
        export STARSHIP_LOG=error
      fi
    '';
  };
}