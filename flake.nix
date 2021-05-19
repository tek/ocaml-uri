{
  description = "OCaml package 'uri'";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { nixpkgs, flake-utils, ... }:
  let
    flake = system:
    let
      pkgs = import nixpkgs { inherit system; };
      deps = [
        pkgs.bazel
        pkgs.pkg-config
        pkgs.opam
        pkgs.autoconf
        pkgs.libtool
        pkgs.binutils
      ];
    in {
      devShell = pkgs.mkShell {
        buildInputs = deps;
      };
    };
  in flake-utils.lib.eachDefaultSystem flake;
}
