let
  f =
    { pkgs, ... }:
    let
      vimrc = builtins.readFile ../config/vimrc;
    in
    {
      programs.vim = {
        enable = true;
        plugins = with pkgs.vimPlugins; [
          lightline-vim
          catppuccin-vim
          rainbow
          LeaderF
          vim-commentary
          vim-rooter
          vim-lastplace
          vim-floaterm
          vim-one
          vim-smoothie

          coc-nvim
          coc-go
          coc-json
          coc-vimlsp
          coc-explorer
          coc-pyright
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
        extraConfig = vimrc;
      };
    };

in
{
  hmModules = [ f ];
}
