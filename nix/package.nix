{
  dpkg,
  fetchurl,
  stdenv,
}:
stdenv.mkDerivation {
  pname = "yandex-music-nix";
  version = "5.84.1";

  src = fetchurl {
    url = "https://desktop.app.music.yandex.net/stable/Yandex_Music_amd64_5.84.1.deb";
    hash = "sha256-jOseroCghFJqg+BM7fgBG925chBxtq96lZ3yXw99BaU=";
  };

  nativeBuildInputs = [dpkg];

  dontConfigure = true;
  dontBuild = true;

  unpackPhase = "true";

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    dpkg-deb -x "$src" "$out"

    runHook postInstall
  '';
}
