inputs@{ nixpkgs, home-manager, nixos-wsl, ... }:
nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";
  specialArgs = inputs // { inherit system; username = "ph"; };

  modules = [
    nixos-wsl.nixosModules.default

    {
      wsl = {
        enable = true;
        defaultUser = "ph";
      };
    }
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
          ../home/fish.nix
          ../home/vim
          ../home/neovim.nix
          ../home/yazi

          ({ pkgs, lib, ... }:
            (import ../home/dev.nix ({ inherit pkgs lib; } // { useRust = true; useGcc = true; useGo = true; }))
          )
        ];
      };
    }
  ];
}
