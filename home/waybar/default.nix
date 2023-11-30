{ pkgs, ... }: {
  home.packages = with pkgs; [ waybar ];
  programs.waybar = {
    enable = true;
  };
  xdg.configFile."waybar/config".source = ./config;
  xdg.configFile."waybar/style.css".source = ./style.css;
}
