{ ... }: {
  systemModule = { pkgs, ... }: {
    services = {
      xserver = {
        enable = true;
        displayManager = {
          defaultSession = "plasma";
          sddm = {
            enable = true;
            wayland.enable = true;
          };
        };

        desktopManager.plasma6.enable = true;
      };
    };


    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      elisa
      # gwenview
      # okular
      oxygen
      khelpcenter
      konsole
      # plasma-browser-integration
      print-manager
    ];

    environment.systemPackages = (with pkgs; [
      numix-cursor-theme
      catppuccin-cursors
      catppuccin-gtk

      bibata-cursors
      adwaita-qt
      gnome.adwaita-icon-theme
    ]) ++ (with pkgs.qt6Packages; [
      # plasma-browser-integration
      qtstyleplugin-kvantum
    ]);
  };

  homeModule = { ... }: { };
}
