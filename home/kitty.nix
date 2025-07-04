{ ... }:
let
  fontName = "FiraCode Nerd Font";
  # nerdFontFallback = "Maple Mono NF";
  nerdFontFallback = "Symbols Nerd Font";
  opacity = "0.85";
  fontSize = 12;
  colorscheme = ''
    ## name:     Catppuccin Kitty Mocha
    ## author:   Catppuccin Org
    ## license:  MIT
    ## upstream: https://github.com/catppuccin/kitty/blob/main/themes/mocha.conf
    ## blurb:    Soothing pastel theme for the high-spirited!



    # The basic colors
    foreground              #cdd6f4
    background              #1e1e2e
    selection_foreground    #1e1e2e
    selection_background    #f5e0dc

    # Cursor colors
    cursor                  #f5e0dc
    cursor_text_color       #1e1e2e

    # URL underline color when hovering with mouse
    url_color               #f5e0dc

    # Kitty window border colors
    active_border_color     #b4befe
    inactive_border_color   #6c7086
    bell_border_color       #f9e2af

    # OS Window titlebar colors
    wayland_titlebar_color system
    macos_titlebar_color system

    # Tab bar colors
    active_tab_foreground   #11111b
    active_tab_background   #cba6f7
    inactive_tab_foreground #cdd6f4
    inactive_tab_background #181825
    tab_bar_background      #11111b

    # Colors for marks (marked text in the terminal)
    mark1_foreground #1e1e2e
    mark1_background #b4befe
    mark2_foreground #1e1e2e
    mark2_background #cba6f7
    mark3_foreground #1e1e2e
    mark3_background #74c7ec

    # The 16 terminal colors

    # black
    color0 #45475a
    color8 #585b70

    # red
    color1 #f38ba8
    color9 #f38ba8

    # green
    color2  #a6e3a1
    color10 #a6e3a1

    # yellow
    color3  #f9e2af
    color11 #f9e2af

    # blue
    color4  #89b4fa
    color12 #89b4fa

    # magenta
    color5  #f5c2e7
    color13 #f5c2e7

    # cyan
    color6  #94e2d5
    color14 #94e2d5

    # white
    color7  #bac2de
    color15 #a6adc8
  '';
  symbolMaps = ''
    ###########################################################
    # Symbols Nerd Font complete symbol_map
    # easily troubleshoot missing/incorrect characters with:
    #   kitty --debug-font-fallback
    ###########################################################

    # "Nerd Fonts - Pomicons"
    symbol_map  U+E000-U+E00D ${nerdFontFallback}

    # "Nerd Fonts - Powerline"
    symbol_map U+e0a0-U+e0a2,U+e0b0-U+e0b3 ${nerdFontFallback}

    # "Nerd Fonts - Powerline Extra"
    symbol_map U+e0a3-U+e0a3,U+e0b4-U+e0c8,U+e0cc-U+e0d2,U+e0d4-U+e0d4 ${nerdFontFallback}

    # "Nerd Fonts - Symbols original"
    symbol_map U+e5fa-U+e62b ${nerdFontFallback}

    # "Nerd Fonts - Devicons"
    symbol_map U+e700-U+e7c5 ${nerdFontFallback}

    # "Nerd Fonts - Font awesome"
    symbol_map U+f000-U+f2e0 ${nerdFontFallback}

    # "Nerd Fonts - Font awesome extension"
    symbol_map U+e200-U+e2a9 ${nerdFontFallback}

    # "Nerd Fonts - Octicons"
    symbol_map U+f400-U+f4a8,U+2665-U+2665,U+26A1-U+26A1,U+f27c-U+f27c ${nerdFontFallback}

    # "Nerd Fonts - Font Linux"
    symbol_map U+F300-U+F313 ${nerdFontFallback}

    #  Nerd Fonts - Font Power Symbols"
    symbol_map U+23fb-U+23fe,U+2b58-U+2b58 ${nerdFontFallback}

    #  "Nerd Fonts - Material Design Icons"
    symbol_map U+f500-U+fd46 ${nerdFontFallback}

    # "Nerd Fonts - Weather Icons"
    symbol_map U+e300-U+e3eb ${nerdFontFallback}

    # Misc Code Point Fixes
    symbol_map U+21B5,U+25B8,U+2605,U+2630,U+2632,U+2714,U+E0A3,U+E615,U+E62B ${nerdFontFallback}
  '';
in
{
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
