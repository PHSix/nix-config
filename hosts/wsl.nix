inputs@{ nixpkgs, home-manager, nixos-wsl, ... }:
nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";
  specialArgs = inputs // { inherit system; username = "ph"; };

  modules = [
    nixos-wsl.nixosModules.default
    home-manager.nixosModules.home-manager

    {
      wsl = {
        enable = true;
        defaultUser = "ph";
      };
    }
    ../deps/cli.nix
    ../deps/misc.nix
    ../deps/tmux.nix
    ../deps/fish.nix
    ../deps/vim
    ../deps/neovim.nix
    ../deps/yazi
    ../deps/home-manager.nix
    ../deps/nixos.nix
    ../deps/nixpkgs.nix
    ../deps/user.nix
  ];
}
