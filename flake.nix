{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    catppuccin.url = "github:catppuccin/nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { self, nixpkgs-unstable, home-manager, catppuccin, ... }@inputs:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        desktop = nixpkgs-unstable.lib.nixosSystem {
          inherit system;
          modules = [
            ./desktop-configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.faelterman = { pkgs, ... }: {
                  imports = [
                    ./home.nix
                    catppuccin.homeManagerModules.catppuccin
                  ];
                };
              };
            }
          ];
        };
      mbp15 = nixpkgs-unstable.lib.nixosSystem {
          inherit system;
          modules = [
            ./mbp15-configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.faelterman = { pkgs, ... }: {
                  imports = [
                    ./home.nix
                    catppuccin.homeManagerModules.catppuccin
                  ];
                };
              };
            }
          ];
        };

      };
    };
}
