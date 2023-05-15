{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim
    wget
    firefox
    neovim

    wpsoffice-cn
    qq

    git # important, for nix flake dependence
    kitty # for default terminal
  ];
}
