# ███████╗██╗      █████╗ ██╗  ██╗███████╗
# ██╔════╝██║     ██╔══██╗██║ ██╔╝██╔════╝
# █████╗  ██║     ███████║█████╔╝ █████╗
# ██╔══╝  ██║     ██╔══██║██╔═██╗ ██╔══╝
# ██║     ███████╗██║  ██║██║  ██╗███████╗
# ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
#
# Main flake configuration with mkHost helper
# Multi-host NixOS configuration with DRY architecture

{
  description = "My NixOS configurations";
  inputs = {
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    catppuccin.url = "github:catppuccin/nix";
  };
  outputs = { self, nixpkgs-unstable, home-manager, catppuccin, ... }@inputs:
    let
      system = "x86_64-linux";

      # Helper function to create a NixOS host configuration
      mkHost = { hostname, hostConfig, homeConfig }:
        nixpkgs-unstable.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            hostConfig
            ./hosts/common/default.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.faelterman = { pkgs, ... }: {
                  imports = [
                    homeConfig
                    catppuccin.homeModules.catppuccin
                  ];
                };
              };
            }
          ];
        };
    in {
      nixosConfigurations = {
        desktop = mkHost {
          hostname = "desktop";
          hostConfig = ./hosts/desktop/default.nix;
          homeConfig = ./hosts/desktop/home.nix;
        };
        mbp15 = mkHost {
          hostname = "mbp15";
          hostConfig = ./hosts/mbp15/default.nix;
          homeConfig = ./hosts/mbp15/home.nix;
        };
      };
    };
}
