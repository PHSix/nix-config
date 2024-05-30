{ pkgs, ... }: {
  home.packages = with pkgs; [
    htop
    wget
    xsel
    ripgrep
    fzf
    fd
    delta
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
    just
    nixpkgs-fmt
    nix-output-monitor
    unrar

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
      replace-with = 'rsproxy-sparse'
      [source.rsproxy]
      registry = "https://rsproxy.cn/crates.io-index"
      [source.rsproxy-sparse]
      registry = "sparse+https://rsproxy.cn/index/"
      [registries.rsproxy]
      index = "https://rsproxy.cn/crates.io-index"
      [net]
      git-fetch-with-cli = true
    '';
  };
}
