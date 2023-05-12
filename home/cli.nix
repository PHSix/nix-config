{ pkgs, ... }: {
  home.packages = with pkgs; [
    htop
    gcc
    gccStdenv # for treesitter compiling deps

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
    emacs

    nodejs
    go
    rustup
    python311

    # nix language server and formatter
    nil
    nixpkgs-fmt
    sumneko-lua-language-server
  ];
}
