{ pkgs, ... }: {
  home.packages = with pkgs; [
    htop
    clang
    libstdcxx5 # for treesitter compiling deps

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
    python3

    # nix language server and formatter
    nil
    nixpkgs-fmt
    sumneko-lua-language-server
  ];
}
