{ pkgs }:
pkgs.lib.nixosSystem {
  inherit pkgs;
  system = "x86_64-linux";

  modules = [
    ./hardware/hardware-configuration.nix

    ./module/hyprland.nix
    ./module/network.nix
    ./module/grub.nix
    ./module/misc.nix
    ./module/nixos.nix
    ./module/user.nix
    ./module/packages.nix
    ./module/locale.nix
    ./module/graphics.nix
    ./module/proxychains.nix

    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.ph = _: {

        imports = [
          ./home
          ./home/cli.nix
          ./home/packages.nix
          ./home/misc.nix
          ./home/tmux.nix
          ./home/kitty.nix
          ./home/alacritty.nix
          ./home/zsh.nix
          ./home/vim
          ./home/waybar
          ./home/hyprland
          ./home/neovim-deps.nix
          ./home/mpd.nix
          ./home/joshuto
          ./home/gitui
          ./home/yazi
        ];
      };
    }
  ];

}
