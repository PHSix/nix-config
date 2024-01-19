{ ... }: {
  systemModule = { pkgs, system, hyprland, lib, ... }: {
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

    programs.regreet = {
      enable = true;
      settings = {
        background.path = "/etc/greetd/background.png";
      };
    };

    environment.etc = {
      "greetd/background.png".source = ../../imgs/default.png;
    };

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


    hardware.pulseaudio.enable = lib.mkForce false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  homeModule = { ... }: {
    imports = [
      ./impl/default.nix
      ../../home/mako
      ../../home/wofi
    ];
  };
}
