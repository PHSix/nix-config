{
  description = "Personal nixos config `flake.nix`.";
  inputs = {
    agenix.url = "github:ryantm/agenix";
    android-nixpkgs .url = "github:tadfisher/android-nixpkgs";
    daeuniverse.url = "github:daeuniverse/flake.nix";
    fenix.url = "github:nix-community/fenix";
    home-manager.url = "github:nix-community/home-manager";
    hyprland.url = "github:hyprwm/Hyprland";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    niri.url = "github:sodiboo/niri-flake";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    stylix.url = "github:danth/stylix";
    wezterm.url = "github:wez/wezterm?dir=nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    coc-nvim-overlay.url = "github:PHSix/coc-nvim-overlay";
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
        overlays = [
          self.overlay

          inputs.coc-nvim-overlay.overlays."${system}".default

          inputs.neovim-nightly-overlay.overlays.default
        ];
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
        "coc-nix"
        "vitesse-nvim"
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
            includedPackage = name: builtins.hasAttr name nixpkgsFor."${system}";
            names = builtins.filter includedPackage providePackageNames;
            packageList = builtins.map (name: { name = name; value = nixpkgsFor."${system}"."${name}"; }) names;
          in
          builtins.listToAttrs packageList
        );
    };
}
