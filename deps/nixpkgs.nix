{
  pkgs,
  rust-overlay,
  android-nixpkgs,
  wezterm,
  aikadm,
  ...
}:
let
  pkgsOverlay = import ../pkgs/overlay.nix;
  wezterm-overlay = (final: prev: { wezterm = wezterm.packages.${pkgs.system}.default; });
  overlays = [
    aikadm.overlays.default
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
