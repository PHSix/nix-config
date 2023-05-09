{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim
    wget
    firefox
    neovim

    wpsoffice-cn
    qq
  ];
}
