{ pkgs, ... }: {
  home.packages = with pkgs;[ wofi ];
  xdg.configFile."wofi/colors".source = ./colors;
  xdg.configFile."wofi/config".source = ./config;
  xdg.configFile."wofi/style.css".source = ./style.css;
}
