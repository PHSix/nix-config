{ pkgs, ... }: {
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      lightline-vim
      catppuccin-vim
      YouCompleteMe
    ];
    settings = {
      ignorecase = true;
      number = true;
      shiftwidth = 4;
      tabstop = 4;
      expandtab = true;
      smartcase = true;
    };
    extraConfig = ''
      set mouse=a
      colorscheme catppuccin_mocha
      let g:lightline = {'colorscheme': 'catppuccin_mocha'}
    '';
  };
}
