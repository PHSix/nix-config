<p>
    <center>
        <img src="./imgs/nixos-logo.png" width=30% />
    </center>
    <center>
        <font size=18 face=bold>
            Nix Configurations for pc, laptop and vms
        </font>
    </center>
</p>

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
