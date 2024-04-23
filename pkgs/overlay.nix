final: prev: {
  monego = prev.callPackage ./fonts/monego.nix { };
  monaco-nerd-font = prev.callPackage ./fonts/monaco-nerd-font.nix { };
  monaco-font = prev.callPackage ./fonts/monaco-font.nix { };
  icursive-nerd-font = prev.callPackage ./fonts/icursive-nerd-font.nix { };
  apifox = prev.callPackage ./apifox.nix { };
  fcitx5-pinyin-zhiwiki = prev.callPackage ./fcitx5-pinyin-zhiwiki.nix { };
  catppuccin-frappe-gtk = prev.callPackage ./catppuccin-frappe-gtk.nix { };

  clash-verge-rev = prev.callPackage ./clash-verge-rev.nix { };
  noi = prev.callPackage ./noi.nix { };

  vimPlugins = prev.vimPlugins // { catppuccin-vim = prev.callPackage ./vimPlugins/catppuccin-vim.nix { }; };
  # selfVimPlugins.catppuccin-vim = prev.callPackage ./vimPlugins/catppuccin-vim.nix { };

  git-butler = prev.callPackage ./git-butler.nix { };

  qq = prev.callPackage ./qq/default.nix { };
}
