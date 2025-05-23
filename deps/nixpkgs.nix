inputs@{
  system,
  rust-overlay,
  android-nixpkgs,
  ...
}:
let
  pkgsOverlay = import ../pkgs/overlay.nix;
  wezterm-overlay = (final: prev: { wezterm = inputs.wezterm.packages.${system}.default; });
  overlays = [
    inputs.aikadm.overlays.default
    pkgsOverlay
    wezterm-overlay
    rust-overlay.overlays.default
    android-nixpkgs.overlays.default
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
