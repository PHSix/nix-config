{ pkgs, ... }:
let
  py-deps = pkgs.python3.withPackages (
    py-pkgs:
    (with py-pkgs; [ autopep8 black python-lsp-server ])
  );
in
{
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
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
      postgresql
      py-deps

      watchman

      gcc
      gccStdenv # for treesitter compiling deps
      gnumake
    ];
  };
}
