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
          vim-one
          vim-smoothie
          vim-oscyank
          vim-caddyfile
          vim-surround
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
