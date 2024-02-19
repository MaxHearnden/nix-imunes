{ docker, fetchFromGitHub, stdenv, which, tcl, tcllib, tk, lib, makeWrapper }:

tcl.mkTclDerivation rec {
  pname = "imunes";
  version = "2.3.0";

  src = fetchFromGitHub {
    owner = "imunes";
    repo = "imunes";
    rev = "v${version}";
    hash = "sha256-Qf5u4oHnsJLGpDPRGSYbxDICL8MWiajxFb5/FADLfqc=";
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
}
