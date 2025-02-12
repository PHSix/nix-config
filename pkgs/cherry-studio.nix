# 在 nix-config 仓库中的 packages/cherry-studio/default.nix

{ appimageTools
, lib
, fetchurl
, electron
}:

let
  pname = "cherry-studio";
  version = "0.9.19";
  src = fetchurl {
    url = "https://github.com/CherryHQ/cherry-studio/releases/download/v${version}/Cherry-Studio-${version}-x86_64.AppImage";
    sha256 = "1krhixpgxnw6phrnz9p7f86cvmpk5janbqbnls9rsic2azypdf31";
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };

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

  extraPkgs = pkgs: (appimageTools.defaultFhsEnvArgs.multiPkgs pkgs) ++ [
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
    description = "Electron-based LLM Client";
    homepage = "https://github.com/cherry-studio/cherry-studio";
    license = licenses.unfree; # 根据实际许可证调整
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
  };
}
