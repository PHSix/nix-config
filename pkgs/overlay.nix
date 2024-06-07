final: prev:
let
  dir = (builtins.readDir ./.);
  packages = builtins.mapAttrs (name: value: if value == "directory" then prev.callPackage ./${name} { } else {
    "${builtins.substring name (builtins.substring - 3)}" = prev.callPackage ./${name} { };
  });
  ps = builtins.zipAttrsWith (name: values: values [ 0 ]) packages;
in
{
  monego = prev.callPackage ./fonts/monego.nix { };
  monaco-nerd-font = prev.callPackage ./fonts/monaco-nerd-font.nix { };
  monaco-font = prev.callPackage ./fonts/monaco-font.nix { };
  hactor = prev.callPackage ./fonts/hactor.nix { };
  icursive-nerd-font = prev.callPackage ./fonts/icursive-nerd-font.nix { };
  fcitx5-pinyin-zhiwiki = prev.callPackage ./fcitx5-pinyin-zhiwiki.nix { };
  catppuccin-frappe-gtk = prev.callPackage ./catppuccin-frappe-gtk.nix { };
  clash-verge-rev = prev.callPackage ./clash-verge-rev/default.nix { };
  vimPlugins = prev.vimPlugins // { catppuccin-vim = prev.callPackage ./vimPlugins/catppuccin-vim.nix { }; };
  qq = prev.callPackage ./qq/default.nix { };
}
