final: prev:
let
  call = x: builtins.mapAttrs (_: value: prev.callPackage value { }) x;
  plugins = call {
    catppuccin-vim = ./vimPlugins/catppuccin-vim.nix;
    hlsearch-nvim = ./vimPlugins/hlsearch-nvim.nix;
    fcitx-nvim = ./vimPlugins/fcitx-nvim.nix;
    vitesse-nvim = ./vimPlugins/vitesse-nvim.nix;
  };
in
(call
  {
    monego = ./fonts/monego.nix;
    monaco-nerd-font = ./fonts/monaco-nerd-font.nix;
    monaco-font = ./fonts/monaco-font.nix;
    hactor = ./fonts/hactor.nix;
    icursive-nerd-font = ./fonts/icursive-nerd-font.nix;
    fcitx5-pinyin-zhiwiki = ./fcitx5-pinyin-zhiwiki.nix;
    catppuccin-frappe-gtk = ./catppuccin-frappe-gtk.nix;
    qq = ./qq/default.nix;
    cherry-studio = ./cherry-studio.nix;
  }) // plugins // {
  vimPlugins = prev.vimPlugins // plugins;
}
