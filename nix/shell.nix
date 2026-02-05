{pkgs}: let
  libPkgs = with pkgs; [
    glib
    nspr
    nss
    dbus

    atk
    at-spi2-core
    cairo
    pango
    pdk
    gtk3
    cups
    libgbm
    expat
    libxkbcommon
    alsa-lib
    libGL
    mesa-demos
    feh

    xorg.libX11
    xorg.libXext
    xorg.libXrender
    xorg.libXrandr
    xorg.libXi
    xorg.libXcursor
    xorg.libXfixes
    xorg.libXdamage
    xorg.libXtst
    xorg.libxcb
    xorg.xcbutil
    xorg.xcbutilwm
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    libXcomposite
  ];
in
  pkgs.mkShell {
    name = "yandex-music-dev";

    nativeBuildInputs = with pkgs; [
      nixd
    ];

    packages = libPkgs;

    shellHook = ''
      export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath libPkgs}"
      echo "Dev shell ready."
    '';
  }
