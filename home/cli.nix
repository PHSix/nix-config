{ pkgs, ... }: {
  home.packages = with pkgs; [
    htop
    clang
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

    # nix language server and formatter
    nil
    nixpkgs-fmt
    sumneko-lua-language-server
  ];
}
