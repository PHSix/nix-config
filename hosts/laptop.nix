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
    ../modules/network.nix
    ../modules/grub.nix
    ../modules/misc.nix
    ../modules/nixpkgs.nix
    ../modules/nixos.nix
    ../modules/user.nix
    ../modules/packages.nix
    ../modules/locale.nix
    ../modules/hybrid-graphics.nix
    ../modules/proxychains.nix

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
