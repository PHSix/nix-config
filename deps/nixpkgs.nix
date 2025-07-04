{
  pkgs,
  rust-overlay,
  android-nixpkgs,
  wezterm,
  ...
}:
let
  pkgsOverlay = import ../pkgs/overlay.nix;
  wezterm-overlay = (final: prev: { wezterm = wezterm.packages.${pkgs.system}.default; });
  overlays = [
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

    system = pkgs.system;
  };
}
