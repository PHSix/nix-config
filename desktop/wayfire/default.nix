{
  systemModule = { pkgs, ... }: {
    programs.wayfire = {
      enable = true;
      plugins = with pkgs.wayfirePlugins; [ wcm wf-shell wayfire-plugins-extra ];
    };

    environment.systemPackages = with pkgs; [
      swaylock
      swayidle
      mako
      kanshi
      cinnamon.nemo
      wlogout
      wlroots
    ];


    xdg.portal = {
      enable = true;
      wlr.enable = true;
    };

    services.seatd = {
      enable = true;
    };
  };
  homeModule = { ... }: { };
}
