# mbp15-configuration.nix
{ config, pkgs, ... }:
{
  imports = [ 
    ./hosts/common/default.nix
    ./hosts/mbp15/default.nix
  ];
  # Any MacBook-specific settings
}
