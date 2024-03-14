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
        # mission-control.scripts = {
        #   fmt = {
        #     description = "Format the top-level Nix files";
        #     exec = "nixpkgs-fmt {./*.nix,./**/*.nix}";
        #     category = "Tools";
        #   };
        #   proxy = {
        #     description =
        #       "Setup http and https proxy for 7897 port(rencently use for clash-verge).";
        #     exec =
        #       "export http_proxy=http://localhost:7897 && export https_proxy=http://localhost:7897";
        #     category = "Tools";
        #   };
        #   build = {
        #     description = "Test build a nixos flake output.";
        #     exec = ''nixos-rebuild build --flake "$1"'';
        #     category = "nixos";
        #   };
        #   rebuild = {
        #     description = "Build a nixos for boot.";
        #     exec = ''sudo -E nixos-rebuild boot --flake "$1"'';
        #     category = "nixos";
        #   };
        #   switch = {
        #     description = "Build a nixos and switch.";
        #     exec = ''sudo -E nixos-rebuild switch --flake "$1" '';
        #     category = "nixos";
        #   };
        #   gc = {
        #     description = "run collect garbage remove unused package.";
        #     exec = "sudo nix-collect-garbage -d";
        #     category = "nix";
        #   };
        #   list-generations = {
        #     description = "list all generations";
        #     exec = "sudo nix-env --profile /nix/var/nix/profiles/system --list-generations";
        #     category = "nixos";
        #   };
        #   remove-generations = {
        #     description = "remove some system generations profile";
        #     exec = ''sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +5'';
        #     category = "nixos";
        #   };
        # };

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

            shellHook = ''
              # auto setup fish env after enter development environment.
              if command -v fish; then
              	exec fish
              elif command -v zsh; then
              	exec zsh
              fi
            '';
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
