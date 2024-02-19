{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { nixpkgs, self }:
  let inherit (nixpkgs) legacyPackages lib; in {
    nixosModules.default = { pkgs }: {
      environment = {
        systemPackages = [
          (pkgs.callPackage ./package.nix { })
        ];
      };
      virtualisation = {
        docker = {
          enable = true;
        };
        vswitch = {
          enable = true;
        };
      };
    };
    packages = lib.mapAttrs (system: pkgs: {
      default = pkgs.callPackage ./package.nix { };
    }) legacyPackages;
  };
}
