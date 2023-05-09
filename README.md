# How to setup this config for my nixos?

1. Exec `sudo -i` enter into root.
2. Parted your system disk and mounted them.
3. Exec `nixos-generate-config --root /mnt` for generate default config.
4. Clone this repository in your system and use your `hardware-configuration.nix`(which generate by `nixos-generate-config` command, it exists in `/mnt/etc/nixos/hardware-configuration.nix`) to replace `hardware/hardware-configuration.nix`
5. Change current path in repository, exec `nixos-rebuild switch --flake .#nixosSystem` and when exec complete enter your root password.
6. Reboot system, set the local userr password. And complete some system presets, like connection network etc.
7. Change current path in repository again, install home-manager by standalone way. And then exec `home-manager switch --flake .#nixosUser` to setup user local environment.
