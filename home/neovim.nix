{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    extraPackages = (with pkgs.python313Packages; [ autopep8 black python-lsp-server ])
      ++ (with pkgs; [
      zls
      gopls # for golang
      python313
      nodejs
      deno
      typescript
      nodePackages.prettier
      vscode-langservers-extracted
      tailwindcss-language-server
      # basedpyright
      nil
      nixpkgs-fmt
      lua-language-server
      stylua

      watchman

      gcc
      gccStdenv # for treesitter compiling deps
      gnumake
    ]);
  };
}
