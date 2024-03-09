{ pkgs
, system
, config
, ...
}:
let
  packages = import ./overlay.nix pkgs pkgs;
in
if system == "x86_64-linux" then
  packages
else
  { }
