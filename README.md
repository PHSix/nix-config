<p align="center">
    <img src="./config/nixos-logo.png" width=30% />
</p>

<h2 align="center">
    Nix Configurations for pc, laptop and vms
</h2>

> This repository stores some flake configurations that I usually use. Includes `master`, `laptop`(long time no use), `wsl` and `orb-vm`.

# The flake output

```bash
$ nix flake show
git+file:///home/ph/nix?ref=refs/heads/master&rev=35c9b0787b0430f436f26e63cd37e44727a6c0c9
├───devShells
│   ├───aarch64-linux
│   │   └───default omitted (use '--all-systems' to show)
│   └───x86_64-linux
│       └───default: development environment 'nix-shell'
├───nixosConfigurations
│   ├───master: NixOS configuration
│   ├───orb-vm: NixOS configuration
│   └───wsl: NixOS configuration
└───overlays
    └───default: Nixpkgs overlay
```

# setup

## master

1. Download the nixos iso file.
2. Disk partition, create a root and boot partition and make format for them.
```bash
# like here
cfdisk /dev/nvme0n1 # create partitions
mkfs.fat -F32 /dev/nvme0n1p1
mkfs.ext4 /dev/nvme0n1p2
```
3. Mount your partition on `/mnt`.
4. Generation nixos configurations in `/mnt`, exec `nixos-generate-config --root /mnt`, and then that will generate a `hardware-configuration.nix` file and `configuration.nix`.
5. Clone this repo to your local. Copy `hardware-configuration.nix` to `${REPO_PATH}/hardware/`.
6. Change `cwd` to `$REPO_PATH` and exec `nixos-install --root /mnt --flake .#master`.
