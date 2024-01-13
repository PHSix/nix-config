{ pkgs, ... }:
let
  extraConfig = builtins.readFile ./vimrc;
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
      shiftwidth = 4;
      tabstop = 4;
      expandtab = true;
      smartcase = true;
    };
    inherit extraConfig;
  };
}
