{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [ gitui ];
  home.file.".config/gitui".source = ./config;
}
