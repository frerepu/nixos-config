{ config, pkgs, lib, ... }:

# ███╗   ███╗██╗██╗  ██╗██╗███╗   ██╗ ██████╗ ███████╗████████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
# ████╗ ████║██║╚██╗██╔╝██║████╗  ██║██╔════╝ ██╔════╝╚══██╔══╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
# ██╔████╔██║██║ ╚███╔╝ ██║██╔██╗ ██║██║  ███╗███████╗   ██║   ███████║   ██║   ██║██║   ██║██╔██╗ ██║
# ██║╚██╔╝██║██║ ██╔██╗ ██║██║╚██╗██║██║   ██║╚════██║   ██║   ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
# ██║ ╚═╝ ██║██║██╔╝ ██╗██║██║ ╚████║╚██████╔╝███████║   ██║   ██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
# ╚═╝     ╚═╝╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
#
# Professional audio mixing control application for digital audio consoles
# Official website: https://mixingstation.app
#
# Supports: Behringer X32, Midas M32, Allen & Heath, Yamaha, and many others

let
  # Fetch the official application icon from Mixing Station's documentation site
  icon = pkgs.fetchurl {
    url = "https://mixingstation.app/ms-docs/assets/ms.png";
    sha256 = "sha256-Kptf7br0X/fHgiuc/G3VBUG2jKOVRWEYFPA0YIwvmgA=";
  };

  mixing-station = pkgs.stdenv.mkDerivation rec {
    pname = "mixing-station";
    version = "latest";

    # Download the latest release directly from Mixing Station's update server
    # Note: This fetches the latest version, so the hash may need updating periodically
    src = pkgs.fetchurl {
      url = "https://mixingstation.app/backend/api/web/download/update/mixing-station-pc/release";
      sha256 = "sha256-9rFnBnlm/wYPvTzCTG6eEpZmQ7hX7ziQcgWbKyq5xaI=";
    };

    # Build-time dependencies
    nativeBuildInputs = with pkgs; [
      makeWrapper  # For creating the executable wrapper
      unzip        # For extracting the downloaded archive
    ];

    # Runtime dependencies for Java and OpenGL/X11 support
    buildInputs = with pkgs; [
      jre              # Java Runtime Environment
      libGL            # OpenGL library
      libGLU           # OpenGL utility library
      xorg.libX11      # X11 protocol client library
      xorg.libXext     # X11 extensions library
      xorg.libXrender  # X11 rendering extension
      xorg.libXi       # X11 input extension
      xorg.libXrandr   # X11 RandR extension (screen resolution)
      xorg.libXxf86vm  # XFree86 video mode extension
    ];

    # Extract the downloaded zip archive
    unpackPhase = ''
      ${pkgs.unzip}/bin/unzip $src
    '';

    installPhase = ''
      # Create necessary directories
      mkdir -p $out/bin $out/share/mixing-station $out/share/applications $out/share/pixmaps

      # Install the JAR file
      cp mixing-station-desktop.jar $out/share/mixing-station/mixing-station-desktop.jar

      # Install the application icon
      cp ${icon} $out/share/pixmaps/mixing-station.png

      # Create executable wrapper with proper Java flags and library paths
      # The -Dorg.lwjgl.opengl.Window.undecorated=false flag ensures window decorations are shown
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

      # Create desktop entry for application launchers
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
  # Add Mixing Station to the user's package collection
  home.packages = [ mixing-station ];
}
