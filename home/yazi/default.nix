{ pkgs, ... }: {
  home.packages = with pkgs; [ yazi ];
  home.file.".config/yazi/yazi.toml".source = ./yazi.toml;
  home.file.".config/yazi/keymap.toml".source = ./keymap.toml;
}
