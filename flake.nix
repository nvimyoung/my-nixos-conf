{
  description = "vimyoung NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    serpantinum.url = "github:ilyamiro/serpantinum";

    };

    outputs = { self, nixpkgs, home-manager, serpantinum, ... }: {
      nixosConfigurations.vimyoung = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit serpantinum; };
      modules = [
        ./configuration.nix
        serpantinum.nixosModules.default
	
	home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
	  home-manager.extraSpecialArgs = { inherit serpantinum; };

          home-manager.users.vimyoung = import ./home.nix;
        }
      ];
    };
  };
}
