{ config, pkgs, lib, ... }:

let
  icon = pkgs.fetchurl {
    url = "https://mixingstation.app/ms-docs/assets/ms.png";
    sha256 = "sha256-Kptf7br0X/fHgiuc/G3VBUG2jKOVRWEYFPA0YIwvmgA=";
  };

  mixing-station = pkgs.stdenv.mkDerivation rec {
    pname = "mixing-station";
    version = "latest";

    src = pkgs.fetchurl {
      url = "https://mixingstation.app/backend/api/web/download/update/mixing-station-pc/release";
      sha256 = "sha256-9rFnBnlm/wYPvTzCTG6eEpZmQ7hX7ziQcgWbKyq5xaI=";
    };

    nativeBuildInputs = with pkgs; [ makeWrapper unzip ];
    buildInputs = with pkgs; [
      jre
      libGL
      libGLU
      xorg.libX11
      xorg.libXext
      xorg.libXrender
      xorg.libXi
      xorg.libXrandr
      xorg.libXxf86vm
    ];

    unpackPhase = ''
      ${pkgs.unzip}/bin/unzip $src
    '';

    installPhase = ''
      mkdir -p $out/bin $out/share/mixing-station $out/share/applications $out/share/pixmaps
      cp mixing-station-desktop.jar $out/share/mixing-station/mixing-station-desktop.jar
      cp ${icon} $out/share/pixmaps/mixing-station.png

      makeWrapper ${pkgs.jre}/bin/java $out/bin/mixing-station \
        --add-flags "-Dorg.lwjgl.opengl.Window.undecorated=false -jar $out/share/mixing-station/mixing-station-desktop.jar" \
        --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath [
          pkgs.libGL
          pkgs.libGLU
          pkgs.xorg.libX11
          pkgs.xorg.libXext
          pkgs.xorg.libXrender
          pkgs.xorg.libXi
          pkgs.xorg.libXrandr
          pkgs.xorg.libXxf86vm
        ]}

      cat > $out/share/applications/mixing-station.desktop <<EOF
      [Desktop Entry]
      Type=Application
      Name=Mixing Station
      Exec=$out/bin/mixing-station
      Icon=mixing-station
      Terminal=false
      Categories=Audio;AudioVideo;
      EOF
    '';
  };
in
{
  home.packages = [ mixing-station ];
}
