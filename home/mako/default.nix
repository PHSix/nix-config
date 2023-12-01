{ pkgs, ... }: {
  home.packages = with pkgs; [ mako ];

  xdg.configFile."mako/config".source = ./config;
  xdg.configFile."mako/icons".source = ./icons;
}
