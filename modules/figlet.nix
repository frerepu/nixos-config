{ config, lib, pkgs, ... }:

let
  ansiShadowFont = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/xero/figlet-fonts/master/ansi_shadow.flf";
    sha256 = "sha256-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx="; # Replace with the actual sha256 hash
  };
in
{
  options = {
    services.figlet = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable figlet service and install fonts.";
      };
    };
  };

  config = lib.mkIf config.services.figlet.enable {
    environment.systemPackages = with pkgs; [
      figlet
    ];

    environment.etc."figlet/fonts/ansi_shadow.flf".source = ansiShadowFont;
  };
}