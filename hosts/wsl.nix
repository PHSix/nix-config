inputs@{ nixpkgs, home-manager, nixos-wsl, ... }:
nixpkgs.lib.nixosSystem rec {
  system = "x86_64";
  specialArgs = inputs // { inherit system; username = "ph"; };

  modules = [
    nixos-wsl.modules

    {
      wsl = {
        enable = true;
        defaultUser = "ph";
      };
    }
    ../modules/nixos.nix
    ../modules/nixpkgs.nix
    ../modules/user.nix

    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.ph = _: {

        imports = [
          ../home
          ../home/cli.nix
          ../home/misc.nix
          ../home/tmux.nix
          ../home/zsh
          ../home/vim
          ../home/neovim.nix
          ../home/yazi
        ];
      };
    }
  ];
}
