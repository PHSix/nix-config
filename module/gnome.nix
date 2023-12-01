{ pkgs, ... }: {
  services = {
    gnome = { gnome-keyring = { enable = true; }; };
    xserver = {
      enable = true;
      # displayManager.gdm.wayland = true;
      desktopManager = { gnome.enable = true; };
      layout = "us";
      xkbOptions = "caps:escape";
      # xkbOptions = "caps:ctrl";
      autoRepeatDelay = 300;
      autoRepeatInterval = 30;
      libinput.enable = true;
      displayManager = {
        gdm.enable = true;
        autoLogin.enable = true;
        autoLogin.user = "ph";
      };
    };
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };

  programs = {
    dconf.enable = true;
    kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    xterm
  ]) ++ (with pkgs.gnome; [
    cheese
    gedit
    epiphany
    geary
    evince
    gnome-music
    gnome-terminal
    gnome-characters
    gnome-contacts
    gnome-initial-setup
    gnome-calculator
    totem
    tali
    iagno
    hitori
    atomix
    yelp
  ]);


  environment.systemPackages = (with pkgs; [
    arc-theme
    ayu-theme-gtk
    pop-gtk-theme
    numix-gtk-theme
    catppuccin-gtk
    pop-icon-theme
    tela-icon-theme
    papirus-icon-theme

    wl-clipboard

    gnome.dconf-editor
    gnome.gnome-tweaks
    gnome.adwaita-icon-theme
    nordic
    # nordzy-icon-theme
    nordzy-cursor-theme
  ]) ++ (with pkgs.gnome; [
    gnome-tweaks
    gnome-boxes
    gnome-screenshot
    gnome-shell-extensions
  ]);
}
