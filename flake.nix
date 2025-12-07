{
  description = "Hyprland on NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.moota = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        # Your NixOS config for the laptop
        ./hosts/laptop/configuration.nix
        ./hosts/laptop/hardware-configuration.nix

        # Home Manager as a NixOS module
        home-manager.nixosModules.home-manager

        # Home Manager settings + your home.nix
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.backupFileExtension = "backup";

          home-manager.users.moota = import ./hosts/laptop/home.nix;
        }
      ];
    };
  };
}
