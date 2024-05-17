{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    extraPackages = (with pkgs.python311Packages; [ autopep8 black python-lsp-server ])
      ++ (with pkgs; [
      gopls # for golang
      python311
      nodejs
      deno
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

      rust-analyzer
      rustfmt
      watchman

      gcc
      gccStdenv # for treesitter compiling deps
      gnumake
    ]);
  };
}
