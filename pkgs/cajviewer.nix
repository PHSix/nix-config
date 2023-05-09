{ stdenv, fetchurl }: stdenv.mkDerivation {
  src = fetchurl {
    url = "https://download.cnki.net/CAJViewer-x86_64-buildubuntu1604-210401.AppImage";
	sha256 = "8aa3e3032bfdbef58084f0bb80edc01ee4d2f0c0bcf4c98629e6c59b5ae0d019";
  };
}
