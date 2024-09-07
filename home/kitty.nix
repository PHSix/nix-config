{ ... }:
let
  fontName = "JetBrains Mono NL";
  # nerdFontFallback = "Maple Mono NF";
  nerdFontFallback = "Symbols Nerd Font";
  opacity = "0.95";
  fontSize = 14;
  colorscheme = ''
    foreground #979eab
    background #282c34

    color0 #282c34
    color1 #e06c75
    color2 #98c379
    color3 #e5c07b
    color4 #61afef
    color5 #be5046
    color6 #56b6c2
    color7 #979eab
    color8 #393e48
    color9 #d19a66
    color10 #56b6c2
    color11 #e5c07b
    color12 #61afef
    color13 #be5046
    color14 #56b6c2
    color15 #abb2bf


    active_tab_foreground   #282c34
    active_tab_background   #979eab
    inactive_tab_foreground #abb2bf
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
