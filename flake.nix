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
  };

  outputs = inputs@{ nixpkgs, home-manager, flake-parts, devshell, ... }:
    let
      local-pkgs-overlay = import ./pkgs;
      system = "x86_64-linux";

      # patch waybar to support hyprland desktop environment
      waybar-overlay = (final: prev: {
        waybar = prev.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
          postPatch = (oldAttrs.postPatch or "") + ''
            sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp'';
        });
      });
      pkgs = import nixpkgs {
        system = system;
        config.allowUnfree = true;
        overlays = [
          local-pkgs-overlay
          inputs.neovim-nightly-overlay.overlay

          waybar-overlay
        ];
      };
    in flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];
      imports = [ inputs.devshell.flakeModule ];

      perSystem = { config, pkgs, ... }: {
        devshells.default = {
          commands = [{
            help = "format project nix files.";
            name = "nixformat";
            command = "nixfmt *.nix && nixfmt ./**/*.nix";
          }];
          packages = with pkgs; [
            vim
            git
            lazygit
            nixfmt
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
          ];
        };
      };

      flake = {
        nixosConfigurations = {
          laptop = import ./hosts/laptop.nix {
            inherit pkgs;
            inherit home-manager;
          };
          master = import ./hosts/master.nix {
            inherit pkgs;
            inherit home-manager;
          };
          orb-vm = import ./hosts/orb-vm {
            inherit pkgs;
            inherit home-manager;
          };
        };
      };
    };
}

