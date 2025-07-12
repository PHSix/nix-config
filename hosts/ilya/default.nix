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
    ../../hardwares/ilya.nix

    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager

    # ../deps/aikami.nix
    ../../deps/agenix.nix
    ../../deps/dae.nix
    ../../deps/docker.nix
    ../../deps/grub.nix
    ../../deps/home-manager.nix
    ../../deps/misc.nix
    ../../deps/network.nix
    ../../deps/nixos.nix
    ../../deps/nixpkgs.nix
    ../../deps/user.nix

    (
      { pkgs, ... }:
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = specialArgs // {
          inherit pkgs;
        };

        home-manager.users."${username}" = import ./home.nix;
      }
    )

    (
      { nvim-flake, system, ... }:
      {
        environment.systemPackages = [ nvim-flake.packages.${system}.minimal ];
      }
    )
  ];
}
