{ pkgs, ... }: {
  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  xdg.configFile."hypr/autostart.sh".source = ./autostart.sh;
}

