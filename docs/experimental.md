# nix experimental commands
1. `nix search`
use for instead of `nix-env -qaP`
2. `nix run`
use for instead of `nix-shell -p`
3. `nix shell`
like `nix-shell`, but have some difference in detail
4. `nix profile`
like `nix-env`, don't use in nixos
5. `nix edit`
can help user quickly edit the package Nix expression in $EDITOR, but not search in nixpkgs source repo. use like `nix edit nixpkgs#hello`
6. `nix flake show`
output your flake.nix products.
```
git+file:///Users/ph/nix
├───devShells
│   ├───aarch64-linux
│   │   └───default: development environment 'nix-shell'
│   └───x86_64-linux
│       └───default omitted (use '--all-systems' to show)
└───nixosConfigurations
    ├───laptop: NixOS configuration
    ├───master: NixOS configuration
    └───orb-vm: NixOS configuration
```
