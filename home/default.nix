{ config, pkgs, ... }:
let
  username = "ph";
in
{
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
  };

  programs.home-manager.enable = true;
}
