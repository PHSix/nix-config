{
  description = "Personal nixos config `flake.nix`.";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-cn = {
      url = "github:nixos-cn/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wezterm = {
      url = "github:wez/wezterm?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    android-nixpkgs = {
      url = "github:tadfisher/android-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # rust package manager
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    daeuniverse.url = "github:daeuniverse/flake.nix";
  };

  outputs = inputs@{ nixpkgs, self, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystem = nixpkgs.lib.genAttrs systems;

      nixpkgsFor = forAllSystem (system: import nixpkgs {
        inherit system;
        overlays = [ self.overlay ];
        config.allowUnfree = true;
      });

      forEachSystem = func: forAllSystem (system: (func { inherit system; pkgs = nixpkgsFor."${system}"; }));

      providePackages = [
        "clash-verge-rev"
        "qq"
        "fcitx5-pinyin-zhiwiki"
        "cherry-studio"
      ];

    in
    rec {
      nixosConfigurations = import ./hosts/default.nix inputs;
      overlay = import ./pkgs/overlay.nix;

      overlays.default = overlay;

      formatter = forEachSystem ({ pkgs, ... }: pkgs.nixpkgs-fmt);
      devShells = forEachSystem ({ pkgs, system, ... }:
        let
          # Helper function to create shell scripts
          mkShellScript = name: text: pkgs.writeShellScriptBin name text;
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              vim
              git
              lazygit
              nixpkgs-fmt
              yazi
              ripgrep
              fzf
              nurl
              htop

              # Custom shell scripts
              (mkShellScript "gc" "sudo nix-collect-garbage -d")
              (mkShellScript "fmt" "nixpkgs-fmt {./*.nix,./**/*.nix}")
              (mkShellScript "build" ''
                if [ -z "$1" ]; then
                  echo "Usage: build <target>"
                  exit 1
                fi
                echo "building $1…"
                nixos-rebuild build --flake $1 -L
              '')
              (mkShellScript "rebuild" ''
                if [ -z "$1" ]; then
                  echo "Usage: rebuild <target>"
                  exit 1
                fi
                echo "rebuilding $1 for boot…"
                sudo nixos-rebuild boot --flake $1 -L
              '')
              (mkShellScript "switch" ''
                if [ -z "$1" ]; then
                  echo "Usage: switch <target>"
                  exit 1
                fi
                echo "building and switching for $1"
                sudo nixos-rebuild switch --flake $1 -L
              '')
              (mkShellScript "remove-profiles" ''
                if [ -z "$1" ]; then
                  echo "Usage: remove-profiles <num>"
                  exit 1
                fi
                sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +$1
              '')
              (mkShellScript "list-profiles" "sudo nix-env --profile /nix/var/nix/profiles/system --list-generations")
              (mkShellScript "daemon-proxy" "sudo sh ./scripts/daemon-proxy.sh")
              (mkShellScript "hash-url" "sudo sh ./scripts/hash.sh")
            ];
          };
        });
      packages = forAllSystem
        (system:
          (builtins.listToAttrs
            (builtins.map
              (package: { name = package; value = nixpkgsFor."${system}"."${package}"; })
              (builtins.filter
                (package: builtins.hasAttr package nixpkgsFor."${system}")
                providePackages
              )
            )
          )
        );
    };
}
