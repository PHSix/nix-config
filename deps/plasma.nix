{ pkgs, ... }: {
  services = {
    displayManager = {
      defaultSession = "plasma";
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
    xserver = {
      enable = true;
    };
    desktopManager.plasma6.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    # gwenview
    # okular
    oxygen
    khelpcenter
    # konsole
    # plasma-browser-integration
    print-manager
  ];

  programs.partition-manager.enable = true;

  environment.systemPackages = (with pkgs; [
    numix-cursor-theme
    catppuccin-cursors
    catppuccin-gtk
    catppuccin-kde

    bibata-cursors
    adwaita-qt
    adwaita-icon-theme

    # enable corner radius
    kde-rounded-corners
  ]) ++ (with pkgs.qt6Packages; [
    # plasma-browser-integration
    qtstyleplugin-kvantum
  ]);
}
