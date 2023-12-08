{ pkgs, system, hyprland, ... }: {
  programs.hyprland = {
    enable = true;

    xwayland = { enable = true; };
    package = hyprland.packages.${system}.hyprland;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  programs = {
    light.enable = true;
    dconf.enable = true;
  };

  # greetd service do not set password on system startup
  services.greetd = {
    enable = true;
    package = pkgs.greetd.gtkgreet;
    settings = {
      default_session = {
        # command = "gtkgreet";
        command = "${lib.makeBinPath [pkgs.greetd.tuigreetd] }/tuigreetd --time --cmd Hyprland";
        # command = "${lib.makeBinPath [pkgs.greetd.gtkgreet] }/gtkgreet --command=Hyprland";
        # command = "${pkgs.hyprland}/bin/Hyprland";
        # command = "${pkgs.greetd.greetd}/bin/greetd --cmd Hyprland";
        # user = "greeter";
      };
      # initial_session = {
      #   command = "${pkgs.hyprland}/bin/Hyprland";
      #   user = "ph";
      # };
    };
  };
  environment.etc."greetd/environments".text = ''
    Hyprland
  '';

  environment.systemPackages = with pkgs; [
    greetd.gtkgreet
    wofi
    copyq
    networkmanagerapplet

    cliphist
    wl-clipboard
    udiskie
    xfce.thunar
    gnome.nautilus
    xdg-utils
    numix-cursor-theme
    catppuccin-cursors
    catppuccin-gtk
    gtk3
    gtk4

    swww
  ];

}
