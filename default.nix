{ pkgs ? import <nixpkgs> {} }:
(pkgs.callPackage ./downstream.nix {
  dev_only_shellcheck = pkgs.shellcheck;
}).overrideAttrs (x: {
  src = ./.;
})
