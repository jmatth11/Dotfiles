
## Rebuilding New Changes

rebuild changes with:
```bash
sudo nixos-rebuild switch --flake .#nixos
```

## Nix Packages

Use [Nix Packages](https://search.nixos.org/packages) to find packages when setting up nixos config or flake files.

## Flake for Development

Placing `flake.nix` files in your directory so you can have dependencies
specific to your projects.

Reference for templates for languages: https://github.com/the-nix-way/dev-templates

Activating the flake development file:
```bash
nix develop
```

When you are done, type `exit` to leave the development flake.
