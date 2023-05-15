{ pkgs, ... }: {
  home.packages = with pkgs; [
    htop
    gcc
    gccStdenv # for treesitter compiling deps
    gnumake

    xsel
    ripgrep
    fzf
    exa
    tree
    zoxide
    mycli
    sqlite
    lazygit
    ranger
    jq
    fx
    neofetch
    bat
    navi # shell command history finder

    # some nix cli utils tool
    nurl
    mpv

    emacs

    nodejs
    go
    rustup
    python310

    # nix language server and formatter
    nil
    nixpkgs-fmt
    sumneko-lua-language-server
  ];

  home.file.".npmrc" = {
    text = ''
      prefix=~/.npm-packages
    '';
  };
}
