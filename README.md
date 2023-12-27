<p align="center">
    <img src="./imgs/nixos-logo.png" width=30% />
</p>

<h2 align="center">
    Nix Configurations for pc, laptop and vms
</h2>

> This repository stores some flake configurations that I usually use. Includes `master`, `laptop` and `orb-vm`.

# The flake output

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
