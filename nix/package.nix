{
  stdenv,
  lib,
  fetchurl,
  dpkg,
  makeWrapper,
  glib,
  gtk3,
  nss,
  nspr,
  atk,
  at-spi2-core,
  cairo,
  pango,
  cups,
  dbus,
  expat,
  libxkbcommon,
  alsa-lib,
  libGL,
  libgbm,
  libx11,
  libxext,
  libxrender,
  libxrandr,
  libxi,
  libxcursor,
  libxfixes,
  libxdamage,
  libxcomposite,
  libxtst,
  libxcb,
  libxcb-util,
  libxcb-wm,
  libxcb-image,
  libxcb-keysyms,
  libxcb-render-util,
  pkgs,
}:
let
  runtimeLibs = [
    glib
    gtk3
    nss
    nspr
    dbus
    atk
    at-spi2-core
    cairo
    pango
    cups
    expat
    libxkbcommon
    alsa-lib
    libGL
    libgbm
    libx11
    libxext
    libxrender
    libxrandr
    libxi
    libxcursor
    libxfixes
    libxdamage
    libxcomposite
    libxtst
    libxcb
    libxcb-util
    libxcb-wm
    libxcb-image
    libxcb-keysyms
    libxcb-render-util
  ];
in
stdenv.mkDerivation {
  pname = "yandex-music-bin";
  version = "5.94.0";

  src = fetchurl {
    url = "https://desktop.app.music.yandex.net/stable/Yandex_Music_amd64_5.94.0.deb";
    hash = "sha256-WgfPxgX4KWX04Q3N2YM8eRjdCm/XJEqaI/zvjg/ABEc=";
  };

  nativeBuildInputs = [
    dpkg
    makeWrapper
    pkgs.lswt
    pkgs.xdotool
  ];

  dontConfigure = true;
  dontBuild = true;

  unpackPhase = "true";

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    dpkg-deb -x "$src" "$out"
    if [ -d "$out/usr/share" ]; then
      mkdir -p "$out/share"
      cp -rT "$out/usr/share" "$out/share"
      rm -rf "$out/usr/share"
    fi
    mkdir -p $out/bin
    makeWrapper "$out/opt/Яндекс Музыка/yandexmusic" "$out/bin/yandexmusic" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath runtimeLibs}" \
      --set-default ELECTRON_IS_DEV 0

    mkdir -p "$out/share/applications"
    cat > "$out/share/applications/yandexmusic.desktop" << EOF
    [Desktop Entry]
    Name=Яндекс Музыка
    Exec=$out/bin/yandexmusic %U
    Terminal=false
    Type=Application
    Icon=yandexmusic
    StartupWMClass=Яндекс Музыка
    Comment=Personal recommendations, mixes for any occasion and the latest musical releases
    MimeType=x-scheme-handler/yandexmusic;
    Categories=Audio;
    StartupNotify=true
    EOF

    runHook postInstall
  '';

  meta = {
    platforms = [ "x86_64-linux" ];
  };
}
