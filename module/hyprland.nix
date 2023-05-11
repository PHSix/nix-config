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


  environment.sessionVariables = {
    # fix gtk application start slow problem, like waybar and clash-verge
    GTK_USE_PORTAL = 0;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.greetd}/bin/greetd --time --cmd Hyprland";
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
