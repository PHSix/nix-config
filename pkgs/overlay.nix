final: prev:
builtins.mapAttrs (_: value: final.callPackage value { }) {
  monego = ./fonts/monego.nix;
  monaco-nerd-font = ./fonts/monaco-nerd-font.nix;
  monaco-font = ./fonts/monaco-font.nix;
  hactor = ./fonts/hactor.nix;
  icursive-nerd-font = ./fonts/icursive-nerd-font.nix;
  fcitx5-pinyin-zhiwiki = ./fcitx5-pinyin-zhiwiki.nix;
  catppuccin-frappe-gtk = ./catppuccin-frappe-gtk.nix;
  cherry-studio = ./cherry-studio.nix;

  eolink = ./eolink.nix;
}
