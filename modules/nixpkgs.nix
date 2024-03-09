inputs@{ system, ... }:
let
  pkgsOverlay = import ../pkgs/overlay.nix;
  wezterm-overlay = (final: prev: {
    wezterm = inputs.wezterm.packages.${system}.default;
  });
  overlays = [
    pkgsOverlay
    wezterm-overlay
    inputs.neovim-nightly-overlay.overlay
  ];

in
{

  nixpkgs.overlays = overlays;
  nixpkgs = {

    config = {
      allowUnfree = true;
      allowAliases = false;
    };

    system = system;
  };
}
