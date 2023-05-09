# {
#   overlay = final: prev:
#     let
#       dirContents = builtins.readDir ../pkgs;
#       genPackage = name: {
#         inherit name;
#         value = final.callPackage (../pkgs + "/${name}") { };
#       };
#       names = builtins.attrNames dirContents;
#     in
#     builtins.listToAttrs (map genPackage names);
# }
self: super: {
  monego = super.callPackage ./monego.nix {};
  apifox = super.callPackage ./apifox.nix {};
  fcitx5-pinyin-zhiwiki = super.callPackage ./fcitx5-pinyin-zhiwiki.nix {};
}
