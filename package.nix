{ docker, fetchFromGitHub, stdenv, which, tcl, tcllib, tk, lib, makeWrapper }:

tcl.mkTclDerivation rec {
  pname = "imunes";
  version = "2.4.0";

  src = fetchFromGitHub {
    owner = "imunes";
    repo = "imunes";
    rev = "v${version}";
    hash = "sha256-6reA4mh5Ub8phz6v4wrlcDeEg3Ycn96i95ZUROtnHhU=";
  };

  buildFlags = ["all"];

  makeFlags = [ "PREFIX=$(out)" ];

  dontBuild = true;

  postInstall = ''
    makeWrapper "${tcl}/bin/tclsh8.6" "$out/bin/imunes" --add-flags "$out/lib/imunes/imunes.tcl" --prefix PATH : ${lib.makeBinPath [ docker ]}
  '';

  nativeBuildInputs = [
    makeWrapper
  ];

  buildInputs = [
    tcllib
    tk
  ];

  meta = {
    maintainers = [ lib.maintainers.maxhearnden];
  };
}
