inputs@{ nixpkgs, home-manager, ... }:
nixpkgs.lib.nixosSystem rec {

  specialArgs = inputs // { inherit system; username = "ph"; };

  system = "aarch64-linux";

  modules = [
    ({ modulesPath, ... }: {
      imports = [
        "${modulesPath}/virtualisation/lxc-container.nix"
      ];
    })
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
          ../home/gitui
          ../home/yazi
        ];
      };
    }
  ];
}
