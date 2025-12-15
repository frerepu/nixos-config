{ config, pkgs, ... }:

{
  # OrcaSlicer with proper XWayland rendering settings
  home.packages = [
    (pkgs.symlinkJoin {
      name = "orca-slicer-wrapped";
      paths = [ pkgs.orca-slicer ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/orca-slicer \
          --set GDK_BACKEND x11 \
          --set GDK_SCALE 1 \
          --set GDK_DPI_SCALE 1 \
          --set QT_AUTO_SCREEN_SCALE_FACTOR 1 \
          --set QT_ENABLE_HIGHDPI_SCALING 1
      '';
    })
  ];
}
