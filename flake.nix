{
  description = "Personal nixos config `flake.nix`.";
  inputs = {
    nixpkgs = { url = "nixpkgs/nixos-unstable"; };
    nixos-cn = {
      url = "github:nixos-cn/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    devshell.url = "github:numtide/devshell";
    flake-root.url = "github:srid/flake-root";

    hyprland.url = "github:hyprwm/Hyprland";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wezterm = {
      url = "github:wez/wezterm?dir=nix";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nixpkgs
    , home-manager
    , flake-parts
    , flake-root
    , ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];
      imports = [
        flake-root.flakeModule
      ];

      perSystem = { lib, pkgs, config, ... }@perInputs: {
        devShells = {
          default = pkgs.mkShell {
            packages = with pkgs; [
              vim
              git
              lazygit
              nixpkgs-fmt
              yazi
              ripgrep
              fzf
              lua-language-server
              nil
              neovim
              nurl
              gnumake
              gcc
              gccStdenv
              htop
              doas
              nixd
            ];
            inputsFrom =
              [
                config.flake-root.devShell
              ];
          };
        };

        packages = import ./pkgs/packages.nix perInputs;
      };

      flake = {
        nixosConfigurations = (import ./hosts/default.nix inputs);

        overlays.default = import ./pkgs/overlay.nix;
      };
    };
}
