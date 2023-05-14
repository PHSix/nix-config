{ pkgs, ... }: {
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      lightline-vim
    ];
    settings = { ignorecase = true; };
    extraConfig = ''
      set mouse=a
    '';
  };
}
