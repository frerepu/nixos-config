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
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs-unstable, home-manager, catppuccin, agenix, ... }@inputs:
    let
      # System configuration
      system = "x86_64-linux";
      pkgs = nixpkgs-unstable.legacyPackages.${system};
      lib = nixpkgs-unstable.lib;

      # User configuration
      username = "faelterman";

      # Host definitions - add new hosts here
      hosts = {
        desktop = {
          hostConfig = ./hosts/desktop/default.nix;
          homeConfig = ./hosts/desktop/home.nix;
        };
        mbp15 = {
          hostConfig = ./hosts/mbp15/default.nix;
          homeConfig = ./hosts/mbp15/home.nix;
        };
      };

      # Helper function to create a NixOS host configuration
      # Automatically integrates home-manager with the specified user
      mkHost = { hostConfig, homeConfig }:
        lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            hostConfig
            ./hosts/common/default.nix
            agenix.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.${username} = {
                  imports = [
                    homeConfig
                    catppuccin.homeModules.catppuccin
                  ];
                };
              };
            }
          ];
        };

      # Helper function to create a standalone home-manager configuration
      mkHomeConfig = { homeConfig }:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            homeConfig
            catppuccin.homeModules.catppuccin
          ];
        };

      # Auto-generate homeConfigurations from host definitions
      # Creates standalone home-manager configs for each host
      mkHomeConfigurations = hosts:
        lib.mapAttrs'
          (hostname: config:
            lib.nameValuePair
              "${username}@${hostname}"
              (mkHomeConfig { inherit (config) homeConfig; })
          )
          hosts;

    in {
      # NixOS system configurations
      # Usage: sudo nixos-rebuild switch --flake .#desktop
      nixosConfigurations = lib.mapAttrs (_: mkHost) hosts;

      # Standalone home-manager configurations (auto-generated from hosts)
      # Usage: home-manager switch --flake .#faelterman@desktop
      homeConfigurations = mkHomeConfigurations hosts;

      # Formatter for 'nix fmt'
      formatter.${system} = pkgs.nixpkgs-fmt;

      # Development shell
      # Usage: nix develop
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          nixpkgs-fmt
          nil
          home-manager.packages.${system}.home-manager
        ];
        shellHook = ''
          echo "NixOS dotfiles development environment"
          echo "Available commands:"
          echo "  nixpkgs-fmt - Format nix files"
          echo "  nil - Nix language server"
          echo "  home-manager - Standalone home-manager"
        '';
      };
    };
}
