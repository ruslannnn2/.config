{
  description = "Ruslan's NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    helium = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { nixpkgs, helium, ... }: {
    nixosConfigurations.rusmachine = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./configuration.nix
        {
          nixpkgs.overlays = [ helium.overlays.default ];
        }
      ];
    };
  };
}
