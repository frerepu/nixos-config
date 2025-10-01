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
    zen-browser.inputs.nixpkgs.follows = "nixpkgs-unstable";
   # zen-browser.inputs.home-manager.follows = "home-manager";
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
