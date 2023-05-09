{stdenv, fetchurl}: stdenv.mkDerivation {
	src = fetchurl {
	};
}
