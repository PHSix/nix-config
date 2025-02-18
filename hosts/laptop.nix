inputs@{ nixpkgs, home-manager, ... }:
let
  desktop = import ../desktop/hyprland/default.nix { };
in
nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";
  specialArgs = inputs // {
    inherit system;
    username = "ph";
  };


  modules = [
    ../hardwares/laptop.nix

    desktop.systemModule
    ../system/network.nix
    ../system/grub.nix
    ../system/misc.nix
    ../system/nixpkgs.nix
    ../system/nixos.nix
    ../system/user.nix
    ../system/packages.nix
    ../system/locale.nix
    ../system/hybrid-graphics.nix
    ../system/proxychains.nix

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
          desktop.homeModule
          ../home
          ../home/cli.nix
          ../home/packages.nix
          ../home/misc.nix
          ../home/tmux.nix
          ../home/kitty.nix
          ../home/alacritty.nix
          ../home/fish.nix
          ../home/vim
          ../home/neovim.nix
          ../home/mpd.nix
          ../home/joshuto
          ../home/gitui
        ];
      };
    }
  ];
}
