{ pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    # default options, you don't need to set them
    # package = hyprland.packages.${pkgs.system}.default;

    xwayland = {
      enable = true;
      hidpi = false;
    };

    nvidiaPatches = false;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  programs = {
    light.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        # command = "${pkgs.greetd.greetd}/bin/greetd --cmd Hyprland";
        user = "ph";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    wofi
    copyq
    networkmanagerapplet

    cliphist
    wl-clipboard
    udiskie
  ];
}
