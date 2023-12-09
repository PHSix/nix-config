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
    # flake root setup for mission-control dependence.
    flake-parts.url = "github:hercules-ci/flake-parts";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    devshell.url = "github:numtide/devshell";
    mission-control.url = "github:Platonic-Systems/mission-control";
    flake-root.url = "github:srid/flake-root";

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs =
    inputs@{ nixpkgs
    , home-manager
    , flake-parts
    , flake-root
    , mission-control
    , ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];
      imports = [ flake-root.flakeModule mission-control.flakeModule ];

      perSystem = { lib, pkgs, config, ... }: {
        mission-control.scripts = {
          fmt = {
            description = "Format the top-level Nix files";
            exec = "nixpkgs-fmt {./*.nix,./**/*.nix}";
            category = "Tools";
          };
          proxy = {
            description =
              "Setup http and https proxy for 7890 port(rencently use for clash).";
            exec =
              "export http_proxy=http://localhost:7890 && export https_proxy=http://localhost:7890";
            category = "Tools";
          };
          build = {
            description = "Test build a nixos flake output.";
            exec = ''nixos-rebuild build --flake "$1"'';
            category = "nixos";
          };
          rebuild = {
            description = "Build a nixos for boot.";
            exec = ''
              sudo nixos-rebuild boot --flake "$1"
            '';
            category = "nixos";
          };
          switch = {
            description = "Build a nixos and switch.";
            exec = ''
              sudo nixos-rebuild switch --flake "$1" 
            '';
            category = "nixos";
          };
          gc = {
            description = "run collect garbage remove unused package.";
            exec = "sudo nix-collect-garbage -d";
            category = "nix";
          };
        };
        devShells.default = pkgs.mkShell {
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
          ];
          inputsFrom =
            [ config.flake-root.devShell config.mission-control.devShell ];

          shellHook = ''
            alias lg=lazygit
            alias yz=yazi
          '';
        };
      };

      flake = { nixosConfigurations = (import ./hosts/default.nix inputs); };
    };
}
