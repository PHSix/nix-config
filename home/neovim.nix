{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    extraPackages = (with pkgs.python311Packages; [ autopep8 black python-lsp-server ])
      ++ (with pkgs; [
      gopls # for golang
      typescript
      # nodePackages.typescript-language-server
      nodePackages.volar
      nodePackages.pyright
      nodePackages.eslint
      nodePackages.prettier
      vscode-langservers-extracted
      tailwindcss-language-server
      # python310Packages.python-lsp-server # for python
      nil
      nixpkgs-fmt
      lua-language-server
      stylua

      # rust-analyzer
      # rustfmt
    ]);
  };
}
