{ stdenv, fetchFromGitHub, ... }:
stdenv.mkDerivation {
  pname = "hactor";
  version = "1.0.0";
  src = fetchFromGitHub {
    owner = "dqisme";
    repo = "Hactor";
    rev = "c5b0f922cb92e4667e84a16d90bad84c7396ed65";
    hash = "sha256-TCxzg8TXFtn5aY9irP8JOXj1YQGDNDHSq6N7dJ7EeHU=";
  };
  installPhase = ''
    find . -name '*.ttf'    -exec install -Dt $out/share/fonts/opentype {} \;
  '';
}
