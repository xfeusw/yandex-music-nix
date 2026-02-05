{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {
    self,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      perSystem = {pkgs, ...}: let
        pkg = pkgs.callPackage ./nix/package.nix {};
        shell = import ./nix/shell.nix {inherit pkgs;};
      in {
        formatter = pkgs.nixfmt-rfc-style;

        devShells.default = shell;

        packages = {
          default = pkg;
        };

        apps = {
          default = {
            type = "app";
            program = "${pkg}/opt/Яндекс\ Музыка/yandex-music";
          };
        };
      };
    };
}
