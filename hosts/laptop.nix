{ pkgs, home-manager, ... }:
let
  desktop = import ../desktop/hyprland/default.nix { };
in
pkgs.lib.nixosSystem {
  inherit pkgs;

  system = "x86_64-linux";

  modules = [
    ../hardware-configuration.nix

    desktop.systemModule
    ../module/network.nix
    ../module/grub.nix
    ../module/misc.nix
    ../module/nixos.nix
    ../module/user.nix
    ../module/packages.nix
    ../module/locale.nix
    ../module/hybrid-graphics.nix
    ../module/proxychains.nix

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
          ../home/waybar
          ../home/neovim.nix
          ../home/mpd.nix
          ../home/joshuto
          ../home/gitui
        ];
      };
    }
  ];
}
