{ pkgs, lib, ... }:
let
  config = {
    mimetype = ''
      [class]
      text_default = [
        { command = "nvim" },
      ]
    '';
  };
in
lib.mkMerge [
  {
    home.packages = with pkgs; [ joshuto ];
  }
  (lib.mkMerge  (map (c: { home.file.".config/joshuto/${c}.toml" = {
  text = config."${c}";
  }; }) (builtins.attrNames config)) )
]
