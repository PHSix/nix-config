inputs@{ nixpkgs, home-manager, ... }:
nixpkgs.lib.nixosSystem rec {

  specialArgs = inputs // { inherit system; username = "ph"; shell = nixpkgs.fish; };

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

    ({ pkgs, ... }: {
      users.users."ph".shell = pkgs.fish;
      programs.fish.enable = true;
    })

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
          # ../home/zsh
          ../home/fish.nix
          ../home/vim
          ../home/neovim.nix
          ../home/gitui
          ../home/yazi

          (import ../home/dev.nix { useRust = true; useGcc = true; useGo = true; })
        ];
      };
    }
  ];
}
