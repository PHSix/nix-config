# Run a program with nix.

Install nix, and then run in bash:
```bash
echo "Hello Nix" | nix run "nixpkgs#ponysay"
```

This will help your to download the ponysay package from nixpkgs's "flake". Then built package and run `bin/ponysay` command

# Explore nix development environment.

`nix develop` command help you setup a development environment from a `flake.nix` file. Like:
```bash
nix develop .#default
# or run
# nix develop "github:PHSix/nix-config#default"
```

Then you can get a nix config development environment.

If you want to only run a command by use some shortcut way, you can try:
```bash
nix develop .#default --command vim
```

# Use nix to build a package in nixpkgs

You can try run: 
```bash
nix build "nixpkgs#cat"
```
Then you get a result folder under your cwd. The "result" will included what you built result from source code.

# Search packages from any flakes which your have importd.

Like run:
```bash
nix search nixpkgs cat
```
You can get some package's name or description included this keyword.
Or use the [search.nixos.org](https://search.nixos.org) can do like that.

# Build your package with nixpkgs

```bash
nix build .#package -L # -L is for print logger
nix run .#package
```

# nix experimental commands
1. `nix search`
use for instead of `nix-env -qaP`
2. `nix run`
use for instead of `nix-shell -p`, run a program with nix. Like `echo "Hello Nix" | nix run "nixpkgs#ponysay"`.
3. `nix shell`
like `nix-shell`, but have some difference in detail
4. `nix profile`
like `nix-env`, don't use in nixos
5. `nix edit`
can help user quickly edit the package Nix expression in $EDITOR, but not search in nixpkgs source repo. use like `nix edit nixpkgs#hello`
6. `nix flake show`
output your flake.nix products.
```
git+file:///home/ph/nix-config
├───devShells
│   ├───aarch64-linux
│   │   └───default omitted (use '--all-systems' to show)
│   └───x86_64-linux
│       └───default: development environment 'nix-shell'
├───formatter
│   ├───aarch64-linux omitted (use '--all-systems' to show)
│   └───x86_64-linux: package 'nixpkgs-fmt-1.3.0'
├───nixosConfigurations
│   ├───master: NixOS configuration
│   ├───orb-vm: NixOS configuration
│   └───wsl: NixOS configuration
├───overlay: Nixpkgs overlay
├───overlays
│   └───default: Nixpkgs overlay
└───packages
    ├───aarch64-linux
    │   ├───catppuccin-frappe-gtk omitted (use '--all-systems' to show)
    │   ├───cherry-studio omitted (use '--all-systems' to show)
    │   ├───fcitx5-pinyin-zhiwiki omitted (use '--all-systems' to show)
    │   ├───hactor omitted (use '--all-systems' to show)
    │   ├───icursive-nerd-font omitted (use '--all-systems' to show)
    │   ├───monaco-font omitted (use '--all-systems' to show)
    │   ├───monaco-nerd-font omitted (use '--all-systems' to show)
    │   ├───monego omitted (use '--all-systems' to show)
    │   └───qq omitted (use '--all-systems' to show)
    └───x86_64-linux
        ├───catppuccin-frappe-gtk: package 'cattpuccin-frappe-gtk-0.2.7'
        ├───cherry-studio: package 'cherry-studio-0.9.24'
        ├───fcitx5-pinyin-zhiwiki: package 'fcitx5-pinyin-zhwiki-20230128'
        ├───hactor: package 'hactor-1.0.0'
        ├───icursive-nerd-font: package 'icursive-nerd-font-1.0.0'
        ├───monaco-font: package 'monaco-1.0.0'
        ├───monaco-nerd-font: package 'monaco-nerd-fonts-1.0.0'
        ├───monego: package 'monego-1.0.0'
        └───qq: package 'qq-3.2.15_250110'
```
