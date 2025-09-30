{
  description = "Based on https://code.m3ta.dev/m3tam3re/nixcfg";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    dotfiles = {
      url = "git+https://github.com/Creeperman1524/dotfiles.git";
      flake = false;
    };
  };

  outputs = { self, dotfiles, home-manager, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      systems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      packages =
        forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = {
        # This is what #da-laptop points to
        da-laptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/da-laptop ];
        };
      };

      homeConfigurations = {
        "ant@da-laptop" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/ant/da-laptop.nix ];
        };
      };
    };
}
