{ stdenv, lib, makeWrapper, dev_only_shellcheck ? null,
fetchFromGitHub,

fzf, coreutils, libxml2, libxslt, jing, findutils, gnugrep, gnused,
docbook5
}:
stdenv.mkDerivation rec {
  name = "xmloscopy-${version}";
  version = "HEAD";

  buildInputs = [
    makeWrapper
    dev_only_shellcheck
  ];

  spath = lib.makeBinPath [
    fzf
    coreutils
    libxml2
    libxslt
    jing
    findutils
    gnugrep
    gnused
  ];

  src = fetchFromGitHub {
    owner = "grahamc";
    repo = "xmloscopy";
    rev = version;
    sha256 = "0000000000000000000000000000000000000000000000000000";
  };

  installPhase = ''
    sed -i "s/hard to say/${version}/" ./xmloscopy
    type -P shellcheck && shellcheck ./xmloscopy
    chmod +x ./xmloscopy
    patchShebangs ./xmloscopy
    mkdir -p $out/bin
    cp ./xmloscopy $out/bin/
    wrapProgram $out/bin/xmloscopy \
      --set RNG "${docbook5}/xml/rng/docbook/docbook.rng" \
      --set PATH "${spath}"
  '';
}
