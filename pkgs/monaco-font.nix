{ stdenv, fetchgit, ... }:
stdenv.mkDerivation {
  pname = "monaco";
  version = "1.0.0";
  src = fetchgit {
    url = "https://github.com/taodongl/monaco.ttf";
    rev = "d258639b562cab674da79e9e3316998e709e8960";
    sha256 = "sha256-aUkI8BUJ1wXj9mPyK8WvpzpUfT8UbVsbAxKB9QKwtk0=";
  };
  installPhase = ''
	find . -name '*.ttf'    -exec install -Dt $out/share/fonts/opentype {} \;
  '';
}

