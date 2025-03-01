final: prev:
(builtins.mapAttrs (_: value: prev.callPackage value { })
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
  }) // {
  vimPlugins = prev.vimPlugins // { catppuccin-vim = prev.callPackage ./vimPlugins/catppuccin-vim.nix { }; };
}
