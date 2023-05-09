# for language
#     font config
#     input method
{ config, pkgs, lib, ... }:
let
  nerdfonts = pkgs.nerdfonts.override {
    fonts = [
      "FiraCode"
      # "Noto"
      "UbuntuMono"
    ];
  };
in
{
  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    supportedLocales = [ "zh_CN.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-chinese-addons
        fcitx5-configtool
        fcitx5-lua
        fcitx5-gtk
        fcitx5-chewing
        fcitx5-pinyin-zhiwiki

        libsForQt5.fcitx5-qt
      ];
    };

  };
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
  };


  location = {
    latitude = 23.0;
    longitude = 113.0;
  };
  environment = {
    sessionVariables = {
      NIX_PROFILES =
        "${builtins.concatStringsSep " " (lib.reverseList config.environment.profiles)}";
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
      XIM = "fcitx";
      XIM_PROGRAM = "fcitx";
      INPUT_METHOD = "fcitx";
      SDL_IM_MODULE = "fcitx";
      GLFW_IM_MODULE = "ibus";
    };
  };

  fonts = {
    enableDefaultFonts = true;
    fontconfig = {
      enable = true;
      hinting = {
        enable = true;
        autohint = false;
        # hintstyle = "hintslight(10px,12px)";
      };
      defaultFonts.emoji = [ "Twitter Color Emoji" "Noto Color Emoji" ];
      defaultFonts.monospace =
        [ "UbuntuMono Nerd Font Mono" "Noto Sans CJK SC" "Sarasa Mono SC" ];
      defaultFonts.sansSerif =
        [ "Noto Sans CJK SC" "LXGW WenKai Mono" "DejaVu Sans" ];
      defaultFonts.serif = [ "Noto Sans CJK SC" "LXGW WenKai Mono" ];

      localConf = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>
          <!-- Use language-specific font variants. -->
          ${
            lib.concatMapStringsSep "\n" ({ lang, variant }:
              let
                replace = from: to: ''
                  <match target="pattern">
                    <test name="lang">
                      <string>${lang}</string>
                    </test>
                    <test name="family">
                      <string>${from}</string>
                    </test>
                    <edit name="family" binding="strong">
                      <string>${to}</string>
                    </edit>
                  </match>
                '';
              in replace "Noto Sans CJK SC" "Noto Sans CJK ${variant}"
              + replace "Noto Serif CJK SC" "Noto Serif CJK ${variant}") [
                {
                  lang = "zh-TW";
                  variant = "TC";
                }
                {
                  lang = "zh-HK";
                  variant = "HK";
                }
                {
                  lang = "ja";
                  variant = "JP";
                }
                {
                  lang = "ko";
                  variant = "KR";
                }
              ]
          }
        </fontconfig>
      '';
    };

    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = (with pkgs; [
      # noto-fonts-cjk
      fira
      fira-code
      symbola # 特殊字符
      jetbrains-mono
      font-awesome

      noto-fonts-emoji
      rofi-emoji
      twitter-color-emoji
      unicode-emoji
      # vistafonts # many windows font(include consolas)
      # TODO: Monaco font and Monego font
      maple-mono-NF
      monego

      cascadia-code
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      sarasa-gothic
      noto-fonts
      wqy_microhei
      wqy_zenhei
      lxgw-wenkai
    ]) ++ [
      pkgs.nerdfonts
      # nerdfonts
    ];
  };
}
