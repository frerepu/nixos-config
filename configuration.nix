{ config, pkgs, ... }:

{
  imports = [ 
    ./hosts/common/default.nix
    ./hosts/desktop/default.nix
  ];
}