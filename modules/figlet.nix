# ███████╗██╗ ██████╗ ██╗     ███████╗████████╗
# ██╔════╝██║██╔════╝ ██║     ██╔════╝╚══██╔══╝
# █████╗  ██║██║  ███╗██║     █████╗     ██║   
# ██╔══╝  ██║██║   ██║██║     ██╔══╝     ██║   
# ██║     ██║╚██████╔╝███████╗███████╗   ██║   
# ╚═╝     ╚═╝ ╚═════╝ ╚══════╝╚══════╝   ╚═╝  

{ config, lib, pkgs, ... }:
{
  options.services.figlet = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable figlet service.";
    };
  };
  
  config = lib.mkIf config.services.figlet.enable {
    # Simply install figlet
    home.packages = with pkgs; [
      figlet
    ];
    
    # Create a simple script that allows you to use the ANSI Shadow font
    home.file.".local/bin/ansi-shadow" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        ${pkgs.figlet}/bin/figlet -f "$(dirname "$(dirname "$(which figlet)")")/share/figlet/fonts/shadow.flf" "$@"
      '';
    };
    
    # Make sure .local/bin exists and is in PATH
    home.activation.createLocalBin = lib.hm.dag.entryBefore ["writeBoundary"] ''
      $DRY_RUN_CMD mkdir -p $VERBOSE_ARG ~/.local/bin
    '';
    
    home.sessionPath = [
      "$HOME/.local/bin"
    ];
  };
}