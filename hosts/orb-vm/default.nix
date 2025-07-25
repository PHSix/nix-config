inputs@{ nixpkgs, home-manager, ... }:

let
  username = "ph";
in
nixpkgs.lib.nixosSystem rec {
  specialArgs = inputs // {
    inherit system username;
    shell = nixpkgs.fish;
  };

  system = "aarch64-linux";

  modules = [
    (
      { modulesPath, ... }:
      {
        imports = [ "${modulesPath}/virtualisation/lxc-container.nix" ];
      }
    )

    home-manager.nixosModules.home-manager

    ../deps/cli.nix
    ../deps/dev.nix
    ../deps/fish.nix
    ../deps/gitui.nix
    ../deps/home-manager.nix
    ../deps/neovim.nix
    ../deps/nixos.nix
    ../deps/nixpkgs.nix
    ../deps/tmux.nix
    ../deps/user.nix
    ../deps/vim.nix
    ../deps/virtualisation.nix
  ];
}
