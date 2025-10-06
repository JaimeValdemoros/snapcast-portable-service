{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.systems.url = "github:nix-systems/default";
  inputs.flake-utils = {
    url = "github:numtide/flake-utils";
    inputs.systems.follows = "systems";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    (flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [self.overlays.default];
        };
      in {
        packages = {
          default = pkgs.symlinkJoin {
            name = "snapcast";
            paths = [pkgs.snapserver-portable-service pkgs.snapclient-portable-service];
          };
          inherit (pkgs) snapserver-portable-service snapclient-portable-service;
        };
        formatter = pkgs.alejandra;
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            bundix
            ruby
          ];
        };
      }
    ))
    // {
      overlays.default = final: prev: {
        snapserver-portable-service = final.callPackage ./snapserver.nix {};
        snapclient-portable-service = final.callPackage ./snapclient.nix {};
      };
      nixosModules.default = {
        pkgs,
        config,
        lib,
        ...
      }: {
        imports = [./nixos-module.nix];
        config = lib.mkIf config.services.pifi.enable {
          nixpkgs.overlays = [self.overlays.default];
        };
      };
    };
}
