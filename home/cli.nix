{ pkgs, ... }: {
  home.packages = with pkgs; [
    htop
    wget
    xsel
    ripgrep
    fzf
    eza
    tree
    zoxide
    mycli
    sqlite
    lazygit
    ranger
    yazi
    w3m
    joshuto # ranger like
    jq
    fx
    neofetch
    fastfetch
    bat

    # some nix cli utils tool
    nurl
    mpv

    termusic
  ];

  home.file.".npmrc" = {
    text = ''
      prefix=~/.npm-packages
      registry=https://registry.npmmirror.com
    '';
  };

  home.file.".cargo/config" = {
    text = ''
      [source.crates-io]
      replace-with = 'ustc'

      [source.ustc]
      registry = "git://mirrors.ustc.edu.cn/crates.io-index"
    '';
  };
}
