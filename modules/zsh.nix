# ███████╗███████╗██╗  ██╗
# ╚══███╔╝██╔════╝██║  ██║
#   ███╔╝ ███████╗███████║
#  ███╔╝  ╚════██║██╔══██║
# ███████╗███████║██║  ██║
# ╚══════╝╚══════╝╚═╝  ╚═╝
{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      c = "clear";
      ls = "ls -lah --color=auto";
      cat = "bat";
      figletas = "figlet -f ~/.local/share/figlet/fonts/ansi_shadow.flf";
    };
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