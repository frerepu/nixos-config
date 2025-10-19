# ███████╗███████╗██╗  ██╗
# ╚══███╔╝██╔════╝██║  ██║
#   ███╔╝ ███████╗███████║
#  ███╔╝  ╚════██║██╔══██║
# ███████╗███████║██║  ██║
# ╚══════╝╚══════╝╚═╝  ╚═╝
{
  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
    envExtra = ''
      # Suppress Starship error messages in non-interactive sessions
      if [[ "$TERM" == "dumb" ]] || [[ ! -t 0 && ! -t 1 ]]; then
        export STARSHIP_LOG=error
      fi
    '';
  };
}