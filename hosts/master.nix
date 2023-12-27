inputs@{ nixpkgs, home-manager, ... }:
nixpkgs.lib.nixosSystem rec {

  specialArgs = inputs // { inherit system; username = "ph"; };
  system = "x86_64-linux";

  modules = [
    ../hardware/hardware-configuration.nix

    ../modules/desktop/plasma.nix
    ../modules/network.nix
    ../modules/grub.nix
    ../modules/misc.nix
    ../modules/nixos.nix
    ../modules/user.nix
    ../modules/packages.nix
    ../modules/nixpkgs.nix
    ../modules/locale.nix
    ../modules/proxychains.nix
    ../modules/amd.nix

    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.ph = _: {

        imports = [
          ../home
          ../home/cli.nix
          ../home/packages.nix
          ../home/misc.nix
          ../home/tmux.nix
          ../home/kitty.nix
          ../home/alacritty.nix
          ../home/wezterm
          ../home/zsh
          ../home/vim
          # ../home/hyprland
          # ../home/mako
          # ../home/wofi
          ../home/neovim.nix
          ../home/mpd.nix
          ../home/joshuto
          ../home/gitui
          ../home/yazi
        ];
      };
    }
  ];

}
