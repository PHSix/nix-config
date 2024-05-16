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
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    hyprland.url = "github:hyprwm/Hyprland";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wezterm = {
      url = "github:wez/wezterm?dir=nix";
    };

    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

    # rust package manager
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, self, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystem = nixpkgs.lib.genAttrs systems;

      nixpkgsFor = forAllSystem (system: import nixpkgs {
        inherit system; overlays = [ self.overlay ];
        config.allowUnfree = true;
      });
      # forEachSystem = func: (builtins.listToAttrs (builtins.map
      #   (system: {
      #     name = system;
      #     value = func {
      #       inherit system;
      #       pkgs = import nixpkgs {
      #         system = "x86_64-linux";
      #         config.allowUnfree = true;
      #       };
      #     };
      #   })
      #   systems
      # ));

      forEachSystem = func: forAllSystem (system: (func { inherit system; pkgs = nixpkgsFor."${system}"; }));

      providePackages = [
        "clash-verge-rev"
        "qq"
        "fcitx5-pinyin-zhiwiki"
      ];
    in
    rec {
      nixosConfigurations = import ./hosts/default.nix inputs;
      overlay = import ./pkgs/overlay.nix;

      overlays.default = overlay;

      formatter = forEachSystem ({ pkgs, ... }: pkgs.nixpkgs-fmt);
      devShells = forEachSystem ({ pkgs, ... }: {
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
          ];
        };
      });
      packages = forAllSystem (system:
        (builtins.listToAttrs
          (builtins.map
            (package: { name = package; value = nixpkgsFor."${system}"."${package}"; })
            (builtins.filter
              (package: builtins.hasAttr package nixpkgsFor."${system}")
              providePackages))
        )
      );
    };
}
