{ lib, stdenv, fetchurl, makeDesktopItem, wrapGAppsHook, atk, at-spi2-atk
, at-spi2-core, alsa-lib, cairo, cups, dbus, expat, gdk-pixbuf, glib, gtk3
, freetype, fontconfig, nss, nspr, pango, udev, libuuid, libX11, libxcb, libXi
, libXcursor, libXdamage, libXrandr, libXcomposite, libXext, libXfixes
, libXrender, libXtst, libXScrnSaver, libxkbcommon, libdrm, mesa, xorg
, copyDesktopItems }:
stdenv.mkDerivation rec {

  pname = "apifox";
  version = "2.2.37";
  src = fetchurl {
    url = "https://cdn.apifox.cn/download/Apifox-linux-manual-latest.tar.gz";
    sha256 = "sha256-VLBlhSYrHH6qkagGnBBXOB/zqjUxLw7NytzsH0ApkRE=";
    name = "${pname}.tar.gz";
  };

  desktopItems = [
    (makeDesktopItem {
      name = "${pname}";
      exec = "${pname}";
      icon = "${pname}";
      comment = "API 一体化协作平台";
      desktopName = "Apifox";
      genericName = "Apifox";
      categories = [ "Development" ];
    })
  ];

  buildInputs = [
    stdenv.cc.cc.lib
    atk
    at-spi2-atk
    at-spi2-core
    alsa-lib
    cairo
    cups
    dbus
    expat
    gdk-pixbuf
    glib
    gtk3
    freetype
    fontconfig
    mesa
    nss
    nspr
    pango
    udev
    libdrm
    libuuid
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
    xorg.libxshmfence
  ];

  nativeBuildInputs = [ wrapGAppsHook copyDesktopItems ];

  installPhase = ''
            runHook preInstall
        	mkdir $out/share/apifox -p
    		cp -R ./* $out/share/apifox
    		ls $out/share/apifox/
    		
        	mkdir $out/bin
        	ln -s $out/share/apifox/apifox $out/bin/apifox
        	mkdir -p $out/share/icons/hicolor/128x128/apps
            ln -s $out/share/apifox/resources/app/dist/assets/logo.png $out/share/icons/apifox.png
            ln -s $out/share/apifox/resources/app/dist/assets/logo.png $out/share/icons/hicolor/128x128/apps/apifox.png
            runHook postInstall
  '';

}
