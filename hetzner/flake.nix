{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # minevent.url = "git+file:///home/julian/code/minevent";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    minevent.url = "git+file:///home/julian/code/minevent";
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      minevent, 
      ...
    }@inputs:
    {
      nixosConfigurations.hetzner01 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          disko.nixosModules.disko
          ./configuration.nix
          ./hardware-configuration.nix
          ./disk-configuration.nix
          minevent.nixosModules.default
        ];
      };
    };
  }

