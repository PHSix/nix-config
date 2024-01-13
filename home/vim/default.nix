{ pkgs, ... }:
let
  vimrc = builtins.readFile ./vimrc;
in
{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      lightline-vim
      edge
      rainbow
      LeaderF
      vim-commentary
      vim-rooter
      vim-lastplace

      coc-nvim
      coc-go
      coc-json
      coc-vimlsp
      coc-explorer
      coc-python
      coc-snippets
      coc-pairs
      coc-git
    ];
    settings = {
      ignorecase = true;
      number = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      smartcase = true;
    };
    extraConfig = ''
      ${vimrc}
    '';
  };
}
