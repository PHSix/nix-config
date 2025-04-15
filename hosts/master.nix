inputs@{ nixpkgs, ... }:
let
  system = "x86_64-linux";
  username = "ph";
  devEnv = {
    rust = true;
    nodejs = true;
    go = true;
    gcc = true;
    python = true;
    ocaml = true;
    deno = true;
    kotlin = true;
  };
  # shell = nixpkgs.legacyPackages.x86_64-linux.;
  specialArgs = inputs // {
    inherit
      system
      username
      devEnv
      ;
  };
in
nixpkgs.lib.nixosSystem {
  inherit specialArgs;
  inherit system;

  modules = [
    ../hardwares/master.nix

    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    ../modules/hmModules.nix

    # ../deps/aikami.nix
    ../deps/agenix.nix
    ../deps/amdgpu.nix
    ../deps/android.nix
    ../deps/cli.nix
    ../deps/dae.nix
    ../deps/dev.nix
    ../deps/emacs.nix
    ../deps/fish.nix
    ../deps/ghostty.nix
    ../deps/gitui.nix
    ../deps/grub.nix
    ../deps/home-manager.nix
    ../deps/kitty.nix
    ../deps/locale.nix
    ../deps/misc.nix
    ../deps/neovim.nix
    ../deps/network.nix
    ../deps/nixos.nix
    ../deps/nixpkgs.nix
    ../deps/ollama.nix
    ../deps/packages.nix
    ../deps/podman.nix
    ../deps/plasma.nix
    ../deps/rofi.nix
    # ../deps/starship.nix
    ../deps/tmux.nix
    ../deps/user.nix
    ../deps/vim.nix
    # ../deps/zsh.nix
  ];
}
