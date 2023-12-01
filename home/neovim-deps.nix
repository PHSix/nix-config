{ pkgs, ... }: {
  # home.packages = with pkgs.python311Packages; [
  #   python-lsp-server
  #   pylsp-mypy
  #   pyls-isort
  #   python-lsp-black
  #   python-lsp-ruff
  # ];
  home.packages = (with pkgs.python310Packages;
    [
      autopep8

    ]) ++ (with pkgs; [
    gopls # for golang
    typescript
    nodePackages.typescript-language-server
    nodePackages.volar
    nodePackages.pyright
    nodePackages.eslint
    nodePackages.prettier
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-json-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    tailwindcss-language-server
    python310Packages.python-lsp-server # for python
    nil
    nixfmt
    nixpkgs-fmt
    lua-language-server

    # rust-analyzer
    # rustfmt
  ]);
}
