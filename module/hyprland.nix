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

  xdg.portal.wlr.enable = true;

  programs = {
    light.enable = true;
  };

  services = {

    gnome = { gnome-keyring = { enable = true; }; };
    xserver = {
      displayManager.gdm.enable = true;
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
