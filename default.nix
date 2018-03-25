{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation rec {
  name = "xmloscopy";

  buildInputs = with pkgs; [
    makeWrapper
    shellcheck
  ];


  spath = pkgs.lib.makeBinPath (with pkgs; [
    fzf
    coreutils
    libxml2
    libxslt
    jing
    findutils
    gnugrep
    gnused
  ]);

  src = ./.;

  installPhase = ''
    shellcheck ./xmloscopy
    chmod +x ./xmloscopy
    patchShebangs ./xmloscopy
    mkdir -p $out/bin
    cp ./xmloscopy $out/bin/
    wrapProgram $out/bin/xmloscopy \
      --set RNG "${pkgs.docbook5}/xml/rng/docbook/docbook.rng" \
      --set PATH "${spath}"
  '';

}
