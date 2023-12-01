inputs@{ nixpkgs, home-manager, ... }:
nixpkgs.lib.nixosSystem rec {

  specialArgs = inputs // { inherit system; };
  # pkgs = import nixpkgs {
  #   config = { allowUnfree = true;
  #     allowAliases = false;
  #   };
  #
  #   system = system;
  # };
  system = "aarch64-linux";

  modules = [

    { }

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
          ../home/zsh.nix
          ../home/vim
          ../home/neovim-deps.nix
          ../home/gitui
          ../home/yazi
        ];
      };
    }
  ];

}

