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

      # genAttrs :: [ String ] -> (String -> Any) -> AttrSet
      # sample: ["a", "b"] -> x: "${x}-1" -> { a = "a-1"; b = "b-1"; }
      genAttrs = nixpkgs.lib.genAttrs;

      forAllSystem = genAttrs systems;

      nixpkgsFor = forAllSystem (system: import nixpkgs {
        inherit system;
        overlays = [ self.overlay ];
        config.allowUnfree = true;
      });

      forEachSystem = func: forAllSystem (system: (func { inherit system; pkgs = nixpkgsFor."${system}"; }));

      providePackageNames = [
        "qq"
        "fcitx5-pinyin-zhiwiki"
        "cherry-studio"
        "monego"
        "monaco-nerd-font"
        "monaco-font"
        "hactor"
        "icursive-nerd-font"
        "catppuccin-frappe-gtk"
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
          mkShellBin = name: text: pkgs.writeShellScriptBin name text;

          binsAttr = import ./shell-scripts.nix;
          binNames = builtins.attrNames binsAttr;
          bins = builtins.map (name: mkShellBin name binsAttr.${name}) binNames;
        in
        {
          default = pkgs.mkShell {
            packages = (with pkgs; [
              vim
              git
              lazygit
              nixpkgs-fmt
              yazi
              ripgrep
              fzf
              nurl
              htop
            ]) ++ bins;
          };
        });

      packages = forAllSystem
        (system:
          let
            hasPackage = name: builtins.hasAttr name nixpkgsFor."${system}";
            names = builtins.filter hasPackage providePackageNames;
            packageList = builtins.map (name: { name = name; value = nixpkgsFor."${system}"."${name}"; }) names;
          in
          builtins.listToAttrs packageList
        );
    };
}
