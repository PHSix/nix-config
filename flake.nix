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
    flake-parts.lib.mkFlake { inherit inputs; } {
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

      flake = { nixosConfigurations = (import ./hosts/default.nix inputs); };
    };
}

