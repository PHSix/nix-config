{...}:
let
  fontName = "Cascadia Code PL";
  symbolMapFont = "FiraCode Nerd Font";
	opacity = "0.8";
	fontSize =14;
  colorscheme = ''
    # https://draculatheme.com/kitty
    #
    # Installation instructions:
    #
    #  cp dracula.conf ~/.config/kitty/
    #  echo "include dracula.conf" >> ~/.config/kitty/kitty.conf
    #
    # Then reload kitty for the config to take affect.
    # Alternatively copy paste below directly into kitty.conf
    foreground            #f8f8f2
    background            #282a36
    selection_foreground  #ffffff
    selection_background  #44475a
    url_color #8be9fd
    # black
    color0  #21222c
    color8  #6272a4
    # red
    color1  #ff5555
    color9  #ff6e6e
    # green
    color2  #50fa7b
    color10 #69ff94
    # yellow
    color3  #f1fa8c
    color11 #ffffa5
    # blue
    color4  #bd93f9
    color12 #d6acff
    # magenta
    color5  #ff79c6
    color13 #ff92df
    # cyan
    color6  #8be9fd
    color14 #a4ffff
    # white
    color7  #f8f8f2
    color15 #ffffff
    # Cursor colors
    cursor            #f8f8f2
    cursor_text_color background
    # Tab bar colors
    active_tab_foreground   #282a36
    active_tab_background   #f8f8f2
    inactive_tab_foreground #282a36
    inactive_tab_background #6272a4
    # Marks
    mark1_foreground #282a36
    mark1_background #ff5555
    # Splits/Windows
    active_border_color #f8f8f2
    inactive_border_color #6272a4
  '';
  symbolMaps = ''
    # "Nerd Fonts - Pomicons"
    symbol_map  U+E000-U+E00D ${symbolMapFont}
    # "Nerd Fonts - Powerline"
    symbol_map U+e0a0-U+e0a2,U+e0b0-U+e0b3 ${symbolMapFont}
    # "Nerd Fonts - Powerline Extra"
    symbol_map U+e0a3-U+e0a3,U+e0b4-U+e0c8,U+e0cc-U+e0d2,U+e0d4-U+e0d4 ${symbolMapFont}
    # "Nerd Fonts - FiraCode original"
    symbol_map U+e5fa-U+e62b ${symbolMapFont}
    # "Nerd Fonts - Devicons"
    symbol_map U+e700-U+e7c5 ${symbolMapFont}
    # "Nerd Fonts - Font awesome"
    symbol_map U+f000-U+f2e0 ${symbolMapFont}
    # "Nerd Fonts - Font awesome extension"
    symbol_map U+e200-U+e2a9 ${symbolMapFont}
    # U+279c
    # "Nerd Fonts - Octicons"
    symbol_map U+f400-U+f4a8,U+2665-U+2665,U+26A1-U+26A1,U+f27c-U+f27c ${symbolMapFont}
    # "Nerd Fonts - Font Linux"
    symbol_map U+F300-U+F313 ${symbolMapFont}
    #  Nerd Fonts - Font Power FiraCode"
    symbol_map U+23fb-U+23fe,U+2b58-U+2b58 ${symbolMapFont}
    #  "Nerd Fonts - Material Design Icons"
    symbol_map U+f500-U+fd46 ${symbolMapFont}
    # "Nerd Fonts - Weather Icons"
    symbol_map U+e300-U+e3eb ${symbolMapFont}
  '';
in {
  programs.kitty = {
    enable = true;
    font = {
      size = fontSize;
      name = fontName;
    };
    settings = {
      background_opacity = opacity;
      enable_audio_bell = "no";
      window_margin_width = "0.0";
      window_padding_width = "0.0";
      cursor_blink_interval = 0;
      confirm_os_window_close = 0;
    };
    extraConfig = colorscheme + symbolMaps;
  };

}
