# desktop-configuration.nix
{ config, pkgs, ... }:
{
  imports = [ 
    ./hosts/common/default.nix
    ./hosts/desktop/default.nix
  ];
  # Any desktop-specific settings
}

