{ pkgs, ... }: {
  home.packages = with pkgs; [
    htop
    gcc
    gccStdenv # for treesitter compiling deps
    gnumake

    neovim-nightly
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
    navi # shell command history finder

    # some nix cli utils tool
    nurl
    mpv

    emacs

    nodejs
    go
    rustup
    # rustc
    # cargo
    python311

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
      replace-with = 'mirror'

      [source.mirror]
      registry = "sparse+https://mirrors.tuna.tsinghua.edu.cn/crates.io-index/"
    '';
  };
}
