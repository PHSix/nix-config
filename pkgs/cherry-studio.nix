{
  appimageTools,
  lib,
  fetchurl,
  electron,
}:
let
  pname = "cherry-studio";
  version = "1.1.7";
  src = fetchurl {
    url = "https://github.com/CherryHQ/cherry-studio/releases/download/v${version}/Cherry-Studio-${version}-x86_64.AppImage";
    sha256 = "sha256-51soGIYEYGWuw8klpqupiV3Ouvx+waENS77au4MWews=";
  };

  appimageContents = appimageTools.extractType2 { inherit pname version src; };

in
appimageTools.wrapType2 {
  inherit pname version src;

  profile = ''
    export LC_ALL=C.UTF-8
    export ELECTRON_IS_DEV=0
    export ELECTRON_FORCE_IS_PACKAGED=true
    export PATH=${lib.makeBinPath [ electron ]}:$PATH
  '';

  multiPkgs = null;

  extraPkgs =
    pkgs:
    (appimageTools.defaultFhsEnvArgs.multiPkgs pkgs)
    ++ [
      pkgs.xorg.libxshmfence
      pkgs.libGL
      pkgs.nss
      pkgs.gtk3
      pkgs.dbus
    ];

  extraInstallCommands = ''
    mkdir -p $out/share/applications $out/share/icons/hicolor/512x512/apps
    cp ${appimageContents}/cherrystudio.desktop $out/share/applications/cherry-studio.desktop
    cp ${appimageContents}/usr/share/icons/hicolor/0x0/apps/cherrystudio.png $out/share/icons/hicolor/512x512/apps/cherry-studio.png

    substituteInPlace $out/share/applications/cherry-studio.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${pname}' \
      --replace-fail 'Icon=cherrystudio' 'Icon=cherry-studio'
      # --replace-fail 'Icon=cherrystudio' 'Icon=$out/share/icons/hicolor/512x512/apps/cherry-studio.png'
  '';

  meta = with lib; {
    description = "🍒 Cherry Studio is a desktop client that supports for multiple LLM providers. Support deepseek-r1 ";
    homepage = "https://github.com/CherryHQ/cherry-studio";
    license = licenses.apsl20;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
  };
}
