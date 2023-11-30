{ pkgs, ... }: {
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      lightline-vim
      catppuccin-vim
      rainbow
      fzf-vim
      LeaderF
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
      set nowrap
      set showcmd
      set wildmenu
      set incsearch
      set hlsearch
      set termguicolors
      set noswapfile
      set cursorline
      colorscheme catppuccin_mocha
      noremap ; :
      vmap fy "+y

      nmap <leader>ff <Cmd>Leaderf file<CR>
      nmap <leader>fo <Cmd>Leaderf mru<CR>
      nmap <leader>fw <Cmd>Leaderf rg<CR>
      nmap <leader>fb <Cmd>Leaderf buffer<CR>
      let g:lightline = {'colorscheme': 'catppuccin_mocha'}
    '';
  };
}
