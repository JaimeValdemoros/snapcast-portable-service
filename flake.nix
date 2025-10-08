{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:JaimeValdemoros/nixpkgs/portable-service-empties";
  inputs.systems.url = "github:nix-systems/default-linux";

  outputs = {
    self,
    nixpkgs,
    systems,
    ...
  }: let
    eachSystem = nixpkgs.lib.genAttrs (import systems);
    legacyPackages = eachSystem (system:
      import nixpkgs {
        inherit system;
        overlays = [self.overlays.default];
      });
  in {
    packages = eachSystem (system: let
      pkgs = legacyPackages.${system};
    in {
      default = pkgs.symlinkJoin {
        name = "snapcast";
        paths = [pkgs.snapserver-portable-service pkgs.snapclient-portable-service];
      };
      inherit (pkgs) snapserver-portable-service snapclient-portable-service;
    });
    formatter = eachSystem (system: legacyPackages.${system}.alejandra);
    devShells = eachSystem (system: {
      default = legacyPackages.${system}.mkShell {
        packages = with legacyPackages.${system}; [
          bundix
          ruby
        ];
      };
    });
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
