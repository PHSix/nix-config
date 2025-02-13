inputs@{ nixpkgs, home-manager, ... }:
let
  desktop = import ../desktop/plasma.nix { };
  system = "x86_64-linux";
  username = "ph";
  specialArgs = inputs // {
    inherit system username;
  };
in
nixpkgs.lib.nixosSystem rec {
  inherit specialArgs;
  inherit system;

  modules = [
    desktop.systemModule

    # dae need secret files to encrypt subscriptions
    inputs.agenix.nixosModules.default
    {
      age.identityPaths = [ "/home/${username}/.age/key.txt" ];
      age.secrets.dae.file = ../secrets/dae.age;
      environment.systemPackages = [
        inputs.agenix.packages.${system}.default
      ];
      imports = [
        ../modules/dae.nix
      ];
    }

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
    # ../modules/ollama.nix

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
          # ../home/wezterm
          ../home/fish.nix
          ../home/zsh
          ../home/vim
          ../home/neovim.nix
          ../home/mpd.nix
          # ../home/joshuto
          ../home/gitui
          ../home/yazi
          ../home/emacs.nix

          (import ../home/dev.nix ({
            useRust = false;
            useGcc = true;
            useGo = true;
          }))
        ];
      };
    }
  ];
}
