inputs@{ nixpkgs, ... }:
let
  system = "x86_64-linux";
  username = "ilya";
  hostName = "ilya";
  devEnv = {
    nodejs = true;
  };
  specialArgs = inputs // {
    inherit
      system
      username
      devEnv
      hostName
      ;
  };
in
nixpkgs.lib.nixosSystem {
  inherit specialArgs;
  inherit system;

  modules = [
    ../hardwares/ilya.nix

    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    ../modules/hmModules.nix

    # ../deps/aikami.nix
    ../deps/agenix.nix
    ../deps/cli.nix
    ../deps/dae.nix
    ../deps/dev.nix
    ../deps/docker.nix
    ../deps/fish.nix
    ../deps/grub.nix
    ../deps/home-manager.nix
    ../deps/misc.nix
    ../deps/network.nix
    ../deps/nixos.nix
    ../deps/nixpkgs.nix
    ../deps/starship.nix
    ../deps/tmux.nix
    ../deps/user.nix
    ../deps/vim.nix
  ];
}
