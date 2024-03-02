{ lib
, fetchurl
, stdenv
, dpkg
, wrapGAppsHook
, autoPatchelfHook
, webkitgtk
, openssl
, tree
}:
stdenv.mkDerivation rec {
  pname = "Noi";
  version = "0.3.0";
  src = fetchurl {
    url = "https://github.com/lencx/Noi/releases/download/v${version}/noi_linux_amd64_${version}.deb";
    hash = "sha256-+7paK28aDVNDakcH5w9nCz8jVzdQmlwLiDZZc3jKYQI=";
  };

  nativeBuildInputs = [
    dpkg
    wrapGAppsHook
    autoPatchelfHook
  ];

  buildInputs = [
    openssl
    stdenv.cc.cc
    webkitgtk
    tree
  ];
  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mv usr/* $out
    tree

    runHook postInstall
  '';


  meta = with lib; {
    description = "🚀 Power Your World with AI - Explore, Extend, Empower.";
    homepage = "https://github.com/lencx/Noi";
    license = licenses.gpl3Plus;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    mainProgram = "noi";
  };
}

