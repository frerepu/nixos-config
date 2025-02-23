# In your home-manager configuration (e.g., home.nix)
{ config, pkgs, ... }:

{
  # Create a wrapper script for Word Web
  home.packages = with pkgs; [
    (writeScriptBin "word" ''
      #!${pkgs.bash}/bin/bash
      ${pkgs.chromium}/bin/chromium \
        --app=https://www.office.com/launch/word \
        --class=word-web
    '')
  ];

  # Create desktop entry for Wofi integration
  xdg.desktopEntries.word = {
    name = "Microsoft Word";
    genericName = "Word Processor";
    exec = "word";
    icon = "word";
    categories = [ "Office" "WordProcessor" ];
    type = "Application";
  };

  # Add icon for the application
  home.file.".local/share/icons/word.png".source = pkgs.fetchurl {
    url = "https://www.microsoft.com/favicon.icon";  # You might want to replace this with a better Word-specific icon URL
    sha256 = "08fdqsw9hnimiwcns4a8sck3jqyi0p33a2806i04w60nfx4azkch"; # You'll need to replace this with the actual hash after downloading the icon
  };
}