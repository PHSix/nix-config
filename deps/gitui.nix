let
  f = { pkgs, ... }:
    {
      home.packages = with pkgs; [ gitui ];
      home.file.".config/gitui/key_bindings.ron".source = ../config/key_bindings.ron;
    };
in
{
  hmModules = [ f ];
}
