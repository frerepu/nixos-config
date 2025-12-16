# ██╗    ██╗ ██████╗ ██████╗ ██████╗ 
# ██║    ██║██╔═══██╗██╔══██╗██╔══██╗
# ██║ █╗ ██║██║   ██║██████╔╝██║  ██║
# ██║███╗██║██║   ██║██╔══██╗██║  ██║
# ╚███╔███╔╝╚██████╔╝██║  ██║██████╔╝
#  ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═════╝ 
{ pkgs, ... }:
{
  # Create a wrapper script for Word Web
  home.packages = with pkgs; [
    (writeScriptBin "word" ''
      #!${pkgs.bash}/bin/bash
      ${pkgs.chromium}/bin/chromium \
        --user-data-dir="$HOME/.config/chromium-word" \
        --app=https://www.office.com/launch/word \
        --class=word-web
    '')
  ];

  # Create desktop entry for Wofi integration
  xdg.desktopEntries.word = {
    name = "Word";
    genericName = "Word Processor";
    exec = "word";
    icon = "word";
    categories = [ "Office" "WordProcessor" ];
    type = "Application";
  };

  # Add icon for the application
  home.file.".local/share/icons/hicolor/256x256/apps/word.png".source = pkgs.fetchurl {
    url = "https://word.office.com/pwa/icon.png";
    sha256 = "08a52gnj4hxnza0s2qc0cd7am7dwaa1zvmpg1qc74wsz644p7cmq";
  };
}