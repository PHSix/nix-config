{ lib
, stdenv
, fetchurl
, dpkg
, wrapGAppsHook
, autoPatchelfHook
, clash-meta
, openssl
, webkitgtk
, udev
, libayatana-appindicator
, tree
}:

stdenv.mkDerivation rec {
  pname = "clash-verge-rev";

  version = "1.5.9";

  src = fetchurl {
    url = "https://github.com/clash-verge-rev/clash-verge-rev/releases/download/v${version}/clash-verge_${version}_amd64.deb";
    # url = "https://github.com/clash-verge-rev/clash-verge-rev/releases/download/v1.4.4/clash-verge_1.4.4_amd64.deb";
    hash = "sha256-dNtA+SW+BNxL+GQQsKFD7BjkTIDPNe1IJ5AiORo1VUw=";
  };

  nativeBuildInputs = [
    dpkg
    wrapGAppsHook
    autoPatchelfHook
  ];

  buildInputs = [
    openssl
    webkitgtk
    stdenv.cc.cc
    tree
  ];

  runtimeDependencies = [
    (lib.getLib udev)
    libayatana-appindicator
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mv usr/* $out
    rm $out/bin/clash-meta

    runHook postInstall
  '';

  postFixup = ''
    ln -s ${lib.getExe clash-meta} $out/bin/clash-meta
  '';

  meta = with lib; {
    description = "Continuation of Clash Verge - A Clash Meta GUI based on Tauri (Windows, MacOS, Linux)";
    homepage = "https://github.com/clash-verge-rev/clash-verge-rev";
    platforms = [ "x86_64-linux" ];
    license = licenses.gpl3Plus;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    maintainers = with maintainers; [ zendo ];
    mainProgram = "clash-verge";
  };
}
