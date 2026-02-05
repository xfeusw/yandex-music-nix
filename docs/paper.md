In September of 2025, I've faced a problem of installing [yandex-music](https://github.com/cucumber-sp/yandex-music-linux) package for my NixOS Desktop. I found out that's basically wrapping Windows .exe file for Linux. Then I tried to fix it by myself, but couldn't do it due to lack of my skills. But around 20 days ago (~20.01.2026), I found out Yandex has released .deb package of Yandex Music. As I haven't seen Nix wrapped of this .deb package and to improve my Nix skills, I decided to "nixify" this package.

Today we'll research how .deb packages work. And how other people "nixifies" them. I'll drop all sources during my research at the end of file.

Firstly, I searched basically "nix wrapping .deb packages". But then,

## Sources

- https://discourse.nixos.org/t/how-to-install-deb-or-rpm/69627/5
- https://www.reddit.com/r/NixOS/comments/16kekht/install_commercial_deb_package_on_nixos/
- http://www.chriswarbo.net/projects/nixos/debian_packages.html
- https://nixos.wiki/wiki/Nixpkgs/Building_RPM_DEB_with_nixpkgs
- https://www.reddit.com/r/NixOS/comments/c0tx8p/which_package_provides_libegl/
