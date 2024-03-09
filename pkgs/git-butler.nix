{ lib
, stdenv
, fetchurl
, dpkg
, wrapGAppsHook
, autoPatchelfHook
, openssl
, webkitgtk
, tree
, git
}:

stdenv.mkDerivation rec {
  pname = "git-butler";
  version = "0.10.22";

  src = fetchurl {
    url = "https://releases.gitbutler.com/releases/release/${version}-703/linux/x86_64/git-butler_${version}_amd64.deb";
    sha256 = "1zawisja47bj53cqa6qak6gqqjxjr1i2d3f4sn8z3a3gdf5hc7pv";
  };

  nativeBuildInputs = [
    dpkg
    wrapGAppsHook
    autoPatchelfHook
    tree
  ];

  buildInputs = [
    openssl
    webkitgtk
    stdenv.cc.cc
    git
  ];

  installPhase = ''
    runHook preInstall
    tree

    mkdir -p $out
    mv usr/* $out

    runHook postInstall
  '';

  meta = with lib; {
    description = "A Git client for simultaneous branches on top of your existing workflow.";
    homepage = "https://gitbutler.com/";
    platforms = [ "x86_64-linux" ];
    license = licenses.mit;
    mainProgram = "git-butler";
  };
}
