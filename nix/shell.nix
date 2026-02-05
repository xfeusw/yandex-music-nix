{pkgs}:
pkgs.mkShell {
  name = "yandex-music-dev";

  packages = with pkgs; [
    libglib
  ];

  shellHook = ''
    echo "Dev shell ready."
  '';
}
