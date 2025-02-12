final: prev:
{
  monego = prev.callPackage ./fonts/monego.nix { };
  monaco-nerd-font = prev.callPackage ./fonts/monaco-nerd-font.nix { };
  monaco-font = prev.callPackage ./fonts/monaco-font.nix { };
  hactor = prev.callPackage ./fonts/hactor.nix { };
  icursive-nerd-font = prev.callPackage ./fonts/icursive-nerd-font.nix { };
  fcitx5-pinyin-zhiwiki = prev.callPackage ./fcitx5-pinyin-zhiwiki.nix { };
  catppuccin-frappe-gtk = prev.callPackage ./catppuccin-frappe-gtk.nix { };
  vimPlugins = prev.vimPlugins // { catppuccin-vim = prev.callPackage ./vimPlugins/catppuccin-vim.nix { }; };
  qq = prev.callPackage ./qq/default.nix { };
  cherry-studio = prev.callPackage ./cherry-studio.nix { };
}
