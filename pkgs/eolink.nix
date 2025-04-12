{
  appimageTools,
  lib,
  fetchurl,
  electron,
  makeWrapper,
  libX11,
  libxcb,
  libXi,
  libXcursor,
  libXdamage,
  libXrandr,
  libXcomposite,
  libXext,
  libXfixes,
  libXrender,
  libXtst,
  libXScrnSaver,
  libxkbcommon,
  ...
}:
let
  pname = "eolink";
  version = "12.4.0";
  src = fetchurl {
    url = "https://data.eolink.com/linux/Eolink-Apikit-${version}.AppImage";
    sha256 = "sha256-uDpZeEAc0ORwXqRTW5nmbBuQKf0ubrU9D2rWi537zI0=";
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
      pkgs.atk
      pkgs.at-spi2-atk
      pkgs.at-spi2-core
      pkgs.alsa-lib
      pkgs.cairo
      pkgs.cups
      pkgs.dbus
      pkgs.expat
      pkgs.gdk-pixbuf
      pkgs.glib
      pkgs.gtk3
      pkgs.freetype
      pkgs.fontconfig
      pkgs.mesa
      pkgs.nss
      pkgs.nspr
      pkgs.pango
      pkgs.udev
      pkgs.libdrm
      pkgs.libsecret
      pkgs.libuuid
      libX11
      libxcb
      libXi
      libXcursor
      libXdamage
      libXrandr
      libXcomposite
      libXext
      libXfixes
      libXrender
      libXtst
      libXScrnSaver
      libxkbcommon
      pkgs.xorg.libxshmfence
    ];

  nativeBuildInputs = [
  ];

  extraInstallCommands = ''
    mkdir -p $out/share/applications $out/share/icons/hicolor/512x512/apps
    cp ${appimageContents}/eolink.desktop $out/share/applications/eolink.desktop
    cp ${appimageContents}/usr/share/icons/hicolor/0x0/apps/eolink.png $out/share/icons/hicolor/512x512/apps/eolink.png

    source "${makeWrapper}/nix-support/setup-hook"
    wrapProgram $out/bin/${pname} \
        --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--enable-features=UseOzonePlatform --ozone-platform=wayland}}"

    substituteInPlace $out/share/applications/eolink.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${pname}'
  '';

  meta = with lib; {
    description = "API 管理的最佳实践产品 快速、规范地管理所有 API";
    homepage = "https://www.eolink.com/apikit";
    license = licenses.unfree;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
  };
}
