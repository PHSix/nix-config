{ pkgs, ... }: {
  home.file.".config/wayfire.ini".source = ./wayfire.ini;

  home.packages = with pkgs; [
    adwaita-qt
    adwaita-icon-theme
  ];
}
