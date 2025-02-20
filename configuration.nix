{ config, pkgs, ... }:

{
  imports = [ 
    #./hardware-configuration.nix  # Keep using the old location temporarily
    ./hosts/common/default.nix
    ./hosts/desktop/default.nix
    ./hosts/desktop/hardware-configuration.nix
  ];
}