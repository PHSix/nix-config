{ stdenv, fetchgit, ... }:
stdenv.mkDerivation {
  pname = "icursive-nerd-font";
  version = "1.0.0";
  src = fetchgit {
    url = "https://github.com/PHSix/icursive-nerd-font";
    rev = "623feb6815753c5679ef4111fb137b8dae4fb983";
    sha256 = "sha256-NJjyOsDCQ+QmCMlP6ZwBOBdEcKqRQdevUIilWr21snU=";
  };
  installPhase = ''
    find . -name '*.otf'    -exec install -Dt $out/share/fonts/opentype {} \;
  '';
}
