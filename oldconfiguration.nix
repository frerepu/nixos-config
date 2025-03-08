# desktop-configuration.nix
{ config, pkgs, ... }:
{
  imports = [ 
    ./hosts/common/default.nix
    ./hosts/desktop/default.nix
  ];
  # Any desktop-specific settings
}

# mbp15-configuration.nix
{ config, pkgs, ... }:
{
  imports = [ 
    ./hosts/common/default.nix
    ./hosts/mbp15/default.nix
  ];
  # Any MacBook-specific settings
}
