{ stdenv, fetchgit, ... }:
stdenv.mkDerivation {
  pname = "monaco-nerd-fonts";
  version = "1.0.0";
  src = fetchgit {
    url = "https://github.com/Karmenzind/monaco-nerd-fonts";
    rev = "a65e20d027a440577c63a28cac1972e796ba4568";
    sha256 = "sha256-+oqtEa6NZwcYBUxMCensDDy0kO7IE0dWkR8jacKEy08=";
  };
  installPhase = ''
    find . -name '*.ttf'    -exec install -Dt $out/share/fonts/opentype {} \;
  '';
}
