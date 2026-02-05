# Yandex Music for Nix

Minimal Nix flake that repackages the official **Yandex Music** `.deb` and runs it from the Nix store.

## Usage

```bash
nix run      # run
nix build    # build
nix develop  # dev-shell
```

## Use in NixOS (overlay)

Add as an input to your system flake:

```nix
inputs.yandex-music.url = "github:xfeusw/yandex-music-nix";
```

Enable the overlay and install the package:

```nix
{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [ inputs.yandex-music.overlays.default ];

  environment.systemPackages = [
    pkgs.yandex-music-bin
  ];
}
```

## How it works

- Fetches the official `.deb`
- Unpacks it with `dpkg-deb -x`
- Exposes the binary as a flake app

No patching, no wrapping.

## Files

- `flake.nix` — package, app, dev shell, overlay
- `nix/package.nix` — fetch + unpack `.deb`
- `nix/shell.nix` — runtime libraries
