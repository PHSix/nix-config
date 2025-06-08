inputs@{
  nixpkgs,
  home-manager,
  nixos-wsl,
  ...
}:
let
  username = "ph";
in
nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";
  specialArgs = inputs // {
    inherit system username;
  };

  modules = [
    nixos-wsl.nixosModules.default
    home-manager.nixosModules.home-manager

    {
      wsl = {
        enable = true;
        defaultUser = username;
      };
    }
    ../../deps/misc.nix
    ../../deps/neovim.nix
    ../../deps/home-manager.nix
    ../../deps/nixos.nix
    ../../deps/nixpkgs.nix
    ../../deps/user.nix

    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = specialArgs;

      home-manager.users."${username}" = import ./home.nix;
    }
  ];
}
