{ pkgs, ... }:
{
  home.file.sumneko-lua-language-server = {
    source = pkgs.sumneko-lua-language-server;
    target = ".local/share/sumneko-lua-language-server";
  };
}
