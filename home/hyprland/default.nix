{pkgs, ...}: {
  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  xdg.configFile."hypr/autostart.sh".source = ./autostart.sh;
  home.file.".config/hypr/scripts/swwl.py".source = ./swwl.py;

  home.packages = [
    pkgs.mako
  ];
}

