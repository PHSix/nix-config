{ lib
, stdenv
, fetchurl
, dpkg
, wrapGAppsHook3
, autoPatchelfHook
  # , clash-meta
, openssl
, webkitgtk
, udev
, libayatana-appindicator
, tree
}:
let
  sources = import ./sources.nix;
  version = sources.version;
  hash = sources.hash;
in
stdenv.mkDerivation {
  pname = "clash-verge-rev";

  inherit version;

  src = fetchurl {
    url = "https://github.com/clash-verge-rev/clash-verge-rev/releases/download/v${version}/clash-verge_${version}_amd64.deb";
    inherit hash;
  };

  nativeBuildInputs = [
    dpkg
    wrapGAppsHook3
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
    # rm $out/bin/clash-meta

    runHook postInstall
  '';

  # postFixup = ''
  #   ln -s ${lib.getExe clash-meta} $out/bin/clash-meta
  # '';

  meta = with lib; {
    description = "Continuation of Clash Verge - A Clash Meta GUI based on Tauri (Windows, MacOS, Linux)";
    homepage = "https://github.com/clash-verge-rev/clash-verge-rev";
    platforms = [ "x86_64-linux" "aarch64-linux" ];
    license = licenses.gpl3Plus;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    maintainers = with maintainers; [ zendo ];
    mainProgram = "clash-verge";
  };
}
