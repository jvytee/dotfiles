{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    minevent.url = "git+file:///home/julian/code/minevent";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.klapprechner = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t460
      ];
    };
  };
}
