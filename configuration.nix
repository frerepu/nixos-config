{ config, pkgs, ... }:

{
  imports = [ 
    ./hosts/common/default.nix
    ./hosts/desktop/default.nix
    ./hosts/mbp15/default.nix
  ];

}
