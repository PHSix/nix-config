{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim
    wget
    firefox
    xplorer
    pkg-config

    git # important, for nix flake dependence
    kitty # for default terminal

    devenv
  ];
}
