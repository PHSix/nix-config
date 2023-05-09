{ stdenv, fetchgit, ... }:
stdenv.mkDerivation {
  pname = "monego";
  version = "1.0.0";
  src = fetchgit {
    url = "https://github.com/cseelus/monego";
    rev = "5309ea4f479d8d65abace95e5bc3012c42497660";
    sha256 = "sha256-UKXrqleQACZljCxd2emX1/zRCjQegjPhc3DN2YoOQ2U=";
  };
  installPhase = ''
	find . -name '*.otf'    -exec install -Dt $out/share/fonts/opentype {} \;
  '';
}
