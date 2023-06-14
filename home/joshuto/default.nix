{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [ joshuto file ];
  home.file.".config/joshuto".source = ./config;
}
