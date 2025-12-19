{
  description = "flake file for system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    player.url = "git+https://codeberg.org/jmatth11/blueZig?ref=main";
  };

  outputs = { self, nixpkgs, player, ... }@inputs:
    let
	system = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${system};
    in
    {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        player.nixosModules.player
        {
          services.player.enable = true;
        }
      ];
    };
  };
}
