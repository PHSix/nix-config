{ pkgs, ... }:
let
  f = _: { home.packages = with pkgs; [ rofi-wayland ]; };
in
{
  hmModules = [ f ];
}
