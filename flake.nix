{
    description = "My first flake";

    
    inputs = {
      nixpkgs.url = "nixpkgs/nixos-24.11";
      home-manager = {
        url = "github:nix-community/home-manager/release-24.11";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      zen-browser.url = "github:0xc000022070/zen-browser-flake";
    };


    outputs = { self, nixpkgs, home-manager, zen-browser,... }: 
      let
        lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
      in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
          ];
        };
      };
      homeConfigurations = {
        faelterman = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            # Add zen-browser module directly here
            { home.packages = [ zen-browser.packages.${system}.default ]; }
          ];
        };
      };
      };
}
