# Yandex Music for Nix

Minimal Nix flake that repackages the official **Yandex Music** `.deb` and runs it from the Nix store.

## Usage:

```bash
nix run - run
nix build - build
nix develop - dev-shell
```

## How it works

- Fetches the official `.deb`
- Unpacks it with `dpkg-deb -x`
- Exposes the binary as a flake app

No patching, no wrapping.

## Files

- `flake.nix` — package, app, dev shell
- `nix/package.nix` — fetch + unpack `.deb`
- `nix/shell.nix` — runtime libraries
