{ pkgs, ... }: {
  home.packages = with pkgs; [ waybar ];
  programs.waybar = {
    enable = true;
  };
  xdg.configFile."waybar/config".source = ./waybar-config;
	xdg.configFile."waybar/style.css".source = ./waybar-style.css;
}
