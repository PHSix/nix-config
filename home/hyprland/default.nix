{ pkgs, ... }: {
  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  xdg.configFile."hypr/autostart.sh".source = ./autostart.sh;
  home.file.".config/hypr/scripts/swwl.py".source = ./swwl.py;

  home.packages = [
    pkgs.mako
  ];

  home.sessionVariables = {
    GTK_THEME = "Catppuccin-Frappe-Pink";
  };
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors;
    name = "Catppuccin-Frappe-Dark";
    size = 16;
  };
  home.pointerCursor.gtk.enable = true;


  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Frappe-Pink";
      package = pkgs.catppuccin-frappe-gtk;
    };
    cursorTheme = {
      name = "Catppuccin-Frappe-Dark";
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

