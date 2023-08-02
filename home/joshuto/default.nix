{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [ joshuto file exiftool ];
  home.file.".config/joshuto".source = ./config;
}
