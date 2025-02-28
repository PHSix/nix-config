{ pkgs, niri, username, ... }:
{
  nixpkgs.overlays = [ niri.overlays.niri ];

  services.displayManager.defaultSession = "niri";

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  xdg.portal = {
    enable = true;
    lxqt = {
      enable = true;
      styles = [ pkgs.libsForQt5.qtstyleplugin-kvantum ];
    };
  };

  services.greetd = {
    enable = true;
    restart = false;
    settings = rec {
      initial_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-user-session --cmd niri-session --greeting 'welcome back'";
        user = username;
      };
      default_session = initial_session;
    };
  };

  # unlock keyring on login
  security.pam.services.greetd.enableGnomeKeyring = true;

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}
