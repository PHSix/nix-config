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
    ../system/nixos.nix
    ../system/nixpkgs.nix
    ../system/user.nix

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

          (import ../home/dev.nix { useRust = true; useGcc = true; useGo = true; })
        ];
      };
    }
  ];
}
