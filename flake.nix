{
  description = "Personal nixos config `flake.nix`.";
  inputs = {
    agenix.url = "github:ryantm/agenix";
    android-nixpkgs.url = "github:tadfisher/android-nixpkgs";
    daeuniverse.url = "github:daeuniverse/flake.nix";
    home-manager.url = "github:nix-community/home-manager";
    niri.url = "github:sodiboo/niri-flake";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.11";
    stylix.url = "github:danth/stylix";
    wezterm.url = "github:wez/wezterm?dir=nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nvim-flake.url = "github:PHSix/nvim-flake";
    aikadm.url = "git+file:///home/ph/repos/aikadm";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extraOptions = ''
      experimental-features = nix-command flakes
      flake-registry = https://cdn.jsdelivr.net/gh/NixOS/flake-registry/flake-registry.json
    '';
    extra-experimental-features = "pipe-operators";
  };

  outputs =
    inputs@{ nixpkgs, self, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      # genAttrs :: [ String ] -> (String -> Any) -> AttrSet
      # sample: ["a", "b"] -> x: "${x}-1" -> { a = "a-1"; b = "b-1"; }
      genAttrs = nixpkgs.lib.genAttrs;

      forAllSystem = genAttrs systems;

      nixpkgsFor = forAllSystem (
        system:
        import nixpkgs {
          inherit system;
          overlays = [
            self.overlay
          ];
          config.allowUnfree = true;
        }
      );

      forEachSystem =
        func:
        forAllSystem (
          system:
          (func {
            inherit system;
            pkgs = nixpkgsFor."${system}";
          })
        );

    in
    rec {
      nixosConfigurations = import ./hosts/default.nix inputs;
      overlay = import ./pkgs/overlay.nix;

      overlays.default = overlay;

      formatter = forEachSystem ({ pkgs, ... }: pkgs.nixpkgs-fmt);
      devShells = forEachSystem (
        { pkgs, system, ... }:
        let
          # Helper function to create shell scripts
          mkShellBin = name: text: pkgs.writeShellScriptBin name text;

          binsAttr = import ./shell-scripts.nix;
          binNames = builtins.attrNames binsAttr;
          bins = builtins.map (name: mkShellBin name binsAttr.${name}) binNames;
        in
        {
          default = pkgs.mkShell {
            packages =
              (with pkgs; [
                inputs.nvim-flake.packages.${system}.nvim
                git
                lazygit
                nixpkgs-fmt
                yazi
                ripgrep
                fzf
                nurl
                htop
              ])
              ++ bins;
          };
        }
      );

      packages = forAllSystem (system: nixpkgsFor."${system}");
    };
}
