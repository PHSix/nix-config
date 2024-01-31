inputs@{ system, ... }:
let
  selfPkgs = import ../pkgs;
  wezterm-overlay = (final: prev: {
    wezterm = inputs.wezterm.packages.${system}.default;
  });
  overlays = [
    selfPkgs
    wezterm-overlay
    # inputs.neovim-nightly-overlay.overlay

    # waybar-overlay
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
