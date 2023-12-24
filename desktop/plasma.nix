{ pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    elisa
    # gwenview
    # okular
    oxygen
    khelpcenter
    konsole
    # plasma-browser-integration
    print-manager
  ];

  environment.systemPackages = with pkgs; [
    numix-cursor-theme
    catppuccin-cursors
    catppuccin-gtk

    bibata-cursors
    adwaita-qt
    gnome.adwaita-icon-theme
    libsForQt5.plasma-browser-integration
  ];
}
