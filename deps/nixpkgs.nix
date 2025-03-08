inputs@{ system, fenix, android-nixpkgs, ... }:
let
  pkgsOverlay = import ../pkgs/overlay.nix;
  wezterm-overlay = (final: prev: {
    wezterm = inputs.wezterm.packages.${system}.default;
  });
  overlays = [
    pkgsOverlay
    wezterm-overlay
    inputs.neovim-nightly-overlay.overlays.default
    fenix.overlays.default
    android-nixpkgs.overlays.default
    inputs.coc-nvim-overlay.overlays."${system}".default
  ];

in
{

  nixpkgs = {
    inherit overlays;

    config = {
      allowUnfree = true;
      allowAliases = false;
      android_sdk.accept_license = true;
    };

    system = system;
  };
}
