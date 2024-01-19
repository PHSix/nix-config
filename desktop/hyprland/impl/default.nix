{ pkgs, ... }: {
  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  xdg.configFile."hypr/autostart.sh".text = ''
    nm-applet &
    python3 ~/.config/hypr/scripts/swwl.py &
    udiskie &
    fcitx5 &
    mako &
    rm /tmp/v2rayA-running.log
    v2rayA --lite >> /tmp/v2rayA-running.log &
  '';
  xdg.configFile."hypr/scripts/swwl.py".source = ./swwl.py;
  home.file.".wallpapers/default.png".source = ../../../imgs/default.png;

  home.packages = with pkgs; [
    mako
    waybar
    adwaita-qt
    gnome.adwaita-icon-theme

    bibata-cursors
  ];

  home.sessionVariables = {
    GTK_THEME = "Catppuccin-Frappe-Pink";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    GDK_BACKEND = "wayland,x11";

    EDITOR = "nvim";
    BROWSER = "microsoft-edge";
    QT_SCALE_FACTOR = "1";
    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    WLR_NO_HARDWARE_CURSORS = "1"; # if no cursor,uncomment this line
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    CLUTTER_BACKEND = "wayland";
    WLR_RENDERER = "vulkan";

    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
  };
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 12;
  };
  home.pointerCursor.gtk.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Frappe-Pink";
      package = pkgs.catppuccin-frappe-gtk;
    };
    cursorTheme = { name = "Bibata-Modern-Classic"; };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    font = {
      name = "LXGW WenKai Mono";
      # name = "Maple Mono NF";
      size = 12;
    };
    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
  };

  programs.waybar = { enable = true; };
  xdg.configFile."waybar/config".source = ./waybar-config;
  xdg.configFile."waybar/style.css".source = ./waybar.css;
}
