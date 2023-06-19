{ pkgs, ... }: {
  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  xdg.configFile."hypr/autostart.sh".source = ./autostart.sh;
  home.file.".config/hypr/scripts/swwl.py".source = ./swwl.py;

  home.packages = [
    pkgs.mako
  ];

  home.sessionVariables = {
    GTK_THEME = "Catppuccin-Frappe-Pink";
    XCURSOR_THEME = "Numix-Cursor";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE="wayland";
    XDG_SESSION_DESKTOP="Hyprland";
    GDK_BACKEND="wayland,x11";
    QT_QPA_PLATFORM="wayland;xcb";
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
      name = "JetBrains Mono";
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
}

