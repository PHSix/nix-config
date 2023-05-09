{pkgs, ...}: {
  services = {
    gnome = { gnome-keyring = { enable = true; }; };
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      # displayManager.gdm.wayland = true;
      desktopManager = { gnome.enable = true; };
      layout = "us";
      xkbOptions = "caps:escape";
      # xkbOptions = "caps:ctrl";
      autoRepeatDelay = 300;
      autoRepeatInterval = 30;
      libinput.enable = true;
    };
  };

  environment.systemPackages = (with pkgs; [
    arc-theme
    ayu-theme-gtk
    pop-gtk-theme
    numix-gtk-theme
    catppuccin-gtk
    pop-icon-theme
    tela-icon-theme
    papirus-icon-theme
  ]) ++ (with pkgs.gnomeExtensions; [
    compiz-alike-magic-lamp-effect
    just-perfection
    gsconnect
    blur-my-shell
    # net-speed-simplified
    pip-on-top
    frequency-boost-switch
	tray-icons-reloaded

  ]) ++ (with pkgs.gnome; [
    gnome-tweaks
    gnome-boxes
    gnome-screenshot
    gnome-shell-extensions
  ]);
}
