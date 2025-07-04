{
  nixpkgs,
  agenix,
  android-nixpkgs,
  daeuniverse,
  home-manager,
  niri,
  nixos-wsl,
  stylix,
  wezterm,
  zen-browser,
  nvim-flake,
  maomaowm,
  aikadm,
  rust-overlay,
  ...
}:
let
  system = "x86_64-linux";
  username = "ph";
  devEnv = {
    rust = false;
    nodejs = true;
    go = true;
    gcc = true;
    python = true;
    ocaml = true;
    deno = true;
    kotlin = true;
  };
  specialArgs = {
    inherit
      agenix
      android-nixpkgs
      daeuniverse
      home-manager
      niri
      nixos-wsl
      stylix
      wezterm
      zen-browser
      nvim-flake
      rust-overlay
      system
      username
      devEnv
      ;
  };
in
nixpkgs.lib.nixosSystem {
  inherit specialArgs;
  system = "x86_64-linux";

  modules = [
    ../../hardwares/master.nix

    agenix.nixosModules.default
    home-manager.nixosModules.home-manager

    ../../deps/agenix.nix
    ../../deps/amdgpu.nix
    ../../deps/android.nix
    ../../deps/dae.nix
    ../../deps/grub.nix
    ../../deps/home-manager.nix
    ../../deps/locale.nix

    ../../deps/misc.nix
    ../../deps/neovim.nix
    ../../deps/network.nix
    ../../deps/nixos.nix
    ../../deps/nixpkgs.nix
    ../../deps/ollama.nix
    ../../deps/packages.nix
    ../../deps/podman.nix
    ../../deps/plasma.nix
    ../../deps/user.nix

    (
      { pkgs, config, ... }:
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = specialArgs // {
          inherit pkgs;
          nixosConfig = config;
        };

        home-manager.users."${username}" = import ./home.nix;
      }
    )
  ];
}
