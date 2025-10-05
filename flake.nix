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
    in {
      nixosConfigurations = {
        desktop = nixpkgs-unstable.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./desktop-configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };  # REMOVED the extra "home-manager." prefix
                users.faelterman = { pkgs, ... }: {
                  imports = [
                    ./home.nix
                    catppuccin.homeModules.catppuccin  # Also fixed the catppuccin warning
                  ];
                };
              };
            }
          ];
        };
        mbp15 = nixpkgs-unstable.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./mbp15-configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };  # REMOVED the extra "home-manager." prefix
                users.faelterman = { pkgs, ... }: {
                  imports = [
                    ./home.nix
                    catppuccin.homeModules.catppuccin  # Also fixed the catppuccin warning
                  ];
                };
              };
            }
          ];
        };
      };
    };
}
