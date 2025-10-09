{ config, pkgs, lib, ... }:

let
  mixing-station = pkgs.stdenv.mkDerivation rec {
    pname = "mixing-station";
    version = "latest";
    
    src = pkgs.fetchzip {
      url = "https://mixingstation.app/backend/api/web/download/update/mixing-station-pc/release";
      sha256 = lib.fakeSha256; # Run once to get the real hash
      stripRoot = false;
    };
    
    nativeBuildInputs = with pkgs; [ makeWrapper ];
    buildInputs = with pkgs; [ jre ];
    
    installPhase = ''
      mkdir -p $out/bin $out/share/mixing-station
      cp -r * $out/share/mixing-station/
      
      makeWrapper ${pkgs.jre}/bin/java $out/bin/mixing-station \
        --add-flags "-jar $out/share/mixing-station/mixing-station-desktop.jar"
    '';
  };
in
{
  environment.systemPackages = [ mixing-station ];
}
