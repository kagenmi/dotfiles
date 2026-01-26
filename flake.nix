{
  description = "Personal dotfiles with Home Manager and Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # SETUP: Replace these values with your username and home directory
      # After changing, run: git update-index --assume-unchanged flake.nix
      username = "YOUR_USERNAME";
      homeDirectory = "/home/YOUR_USERNAME";
    in {
      homeConfigurations = {
        default = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./nix/home.nix
            {
              home.username = username;
              home.homeDirectory = homeDirectory;
            }
          ];
        };
      };
    };
}
