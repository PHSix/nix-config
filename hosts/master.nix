inputs@{ nixpkgs, home-manager, ... }:
let
  desktop = import ../desktop/plasma.nix { };
  system = "x86_64-linux";
  specialArgs = inputs // {
    inherit system;
    username = "ph";
  };
in
nixpkgs.lib.nixosSystem rec {
  inherit specialArgs;
  inherit system;

  modules = [
    desktop.systemModule
    ../hardwares/master.nix

    ../modules/network.nix
    ../modules/grub.nix
    ../modules/misc.nix
    ../modules/nixos.nix
    ../modules/user.nix
    ../modules/packages.nix
    ../modules/nixpkgs.nix
    ../modules/locale.nix
    ../modules/proxychains.nix
    ../modules/amdgpu.nix
    ../modules/android.nix
    ../modules/virtualisation.nix

    ({ pkgs, ... }: {
      users.users."ph".shell = pkgs.zsh;
      programs.zsh.enable = true;
      programs.fish.enable = true;

      networking.firewall.enable = false;
    })


    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = specialArgs;
      home-manager.users.ph = { config, lib, pkgs, ... }: {
        imports = [
          desktop.homeModule
          ../home
          ../home/cli.nix
          ../home/packages.nix
          ../home/misc.nix
          ../home/tmux.nix
          ../home/kitty.nix
          ../home/alacritty.nix
          ../home/wezterm
          ../home/fish.nix
          ../home/zsh
          ../home/vim
          ../home/neovim.nix
          ../home/mpd.nix
          ../home/joshuto
          ../home/gitui
          ../home/yazi
          ../home/emacs.nix

          (import ../home/dev.nix ({
            useRust = true;
            useGcc = true;
            useGo = true;
          }))
        ];
      };
    }
  ];
}
