inputs@{ system, fenix, ... }:
let
  pkgsOverlay = import ../pkgs/overlay.nix;
  wezterm-overlay = (final: prev: {
    wezterm = inputs.wezterm.packages.${system}.default;
  });
  overlays = [
    pkgsOverlay
    wezterm-overlay
    inputs.neovim-flake.overlay

    # (final: prev: {
    #   neovim = inputs.neovim-flake.packages."${system}".neovim;

      # neovim-stable = prev.neovim.overrideAttrs (finalAttrs: previousAttrs: rec {
      #   version = "0.10.0";
      #   src = prev.fetchFromGitHub {
      #     owner = "neovim";
      #     repo = "neovim";
      #     rev = "v${finalAttrs.version}";
      #     hash = "sha256-CcaBqA0yFCffNPmXOJTo8c9v1jrEBiqAl8CG5Dj5YxE=";
      #   };
      #
      # });
    # })
    # inputs.neovim-nightly-overlay.overlay
    fenix.overlays.default
  ];

in
{

  nixpkgs = {
    inherit overlays;

    config = {
      allowUnfree = true;
      allowAliases = false;
    };

    system = system;
  };
}
