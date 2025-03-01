let
  f = { pkgs, ... }: {
    home.packages = with pkgs; [ yazi ];
    home.file.".config/yazi/yazi.toml".source = ../config/yazi.toml;
    home.file.".config/yazi/keymap.toml".source = ../config/keymap.toml;
  };
in
{
  hmModules = [ f ];
}
