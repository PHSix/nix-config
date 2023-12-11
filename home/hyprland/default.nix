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

  home.packages = with pkgs; [
    mako
    waybar
    adwaita-qt
    gnome.adwaita-icon-theme
  ];

  home.sessionVariables = {
    GTK_THEME = "Catppuccin-Frappe-Pink";
    XCURSOR_THEME = "Numix-Cursor";
    # XDG_CURRENT_DESKTOP = "Hyprland";
    # XDG_SESSION_TYPE = "wayland";
    # XDG_SESSION_DESKTOP = "Hyprland";
    GDK_BACKEND = "wayland,x11";
    # QT_QPA_PLATFORM = "wayland;xcb";


    EDITOR = "nvim";
    BROWSER = "microsoft-edge";
    QT_SCALE_FACTOR = "1";
    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    # WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
    WLR_NO_HARDWARE_CURSORS = "1"; # if no cursor,uncomment this line  
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    # GBM_BACKEND = "nvidia-drm";
    CLUTTER_BACKEND = "wayland";
    # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # LIBVA_DRIVER_NAME = "nvidia";
    WLR_RENDERER = "vulkan";
    # __NV_PRIME_RENDER_OFFLOAD = "1";

    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
    XDG_DATA_HOME = "\${HOME}/.local/share";
  };
  home.pointerCursor = {
    package = pkgs.numix-cursor-theme;
    name = "Numix-Cursor";
    size = 12;
  };
  home.pointerCursor.gtk.enable = true;


  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Frappe-Pink";
      package = pkgs.catppuccin-frappe-gtk;
    };
    cursorTheme = {
      name = "Numix-Cursor";
    };
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

  programs.waybar = {
    enable = true;
  };
  xdg.configFile."waybar/config".source = ./waybar-config;
  xdg.configFile."waybar/style.css".source = ./waybar.css;
}
