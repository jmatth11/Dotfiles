
## Rebuilding New Changes

rebuild changes with:
```bash
sudo nixos-rebuild switch --flake .#nixos
```

## Searching Headers/Packages

package is called `nix-index`

To initialize/update registry
```bash
nix-index
```

You only need to run `nix-index` once at the start and then after big changes.
The initial time will take around 5 minutes.

Searching for headers:
```bash
# can be wrapped in a string as well. (i.e. 'X11/Xlib.h')
nix-locate <header name>.h
```


