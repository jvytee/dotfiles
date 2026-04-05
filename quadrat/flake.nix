{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    minevent.url = "git+file:///home/julian/code/minevent";
  };

  outputs = { self, nixpkgs, minevent }@inputs: {
    nixosConfigurations.quadrat = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [ ./configuration.nix ];
    };
  };
}
