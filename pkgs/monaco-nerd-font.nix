{ stdenv, fetchgit, ... }:
stdenv.mkDerivation {
  pname = "monego";
  version = "1.0.0";
  src = fetchgit {
    url = "https://github.com/Karmenzind/monaco-nerd-fonts";
    rev = "a65e20d027a440577c63a28cac1972e796ba4568";
    sha256 = "sha256-UKXrqleQACZljCxd2emX1/zRCjQegjPhc3DN2YoOQ2U=";
  };
  installPhase = ''
	find . -name '*.ttf'    -exec install -Dt $out/share/fonts/opentype {} \;
  '';
}

