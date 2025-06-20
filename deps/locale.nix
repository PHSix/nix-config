# for language
#     font config
#     input method
{
  config,
  pkgs,
  lib,
  ...
}:
{
  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    supportedLocales = [
      "zh_CN.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        # waylandFrontend = true;
        addons = with pkgs; [
          kdePackages.fcitx5-chinese-addons
          kdePackages.fcitx5-configtool
          kdePackages.fcitx5-qt

          fcitx5-lua
          fcitx5-gtk
          fcitx5-pinyin-moegirl
          fcitx5-pinyin-zhwiki
          fcitx5-chewing
        ];
      };
    };

  };

  location = {
    latitude = 23.0;
    longitude = 113.0;
  };
  environment = {
    sessionVariables = {
      # to fix chrome or edge which core is chormium v8 case input trrigger unstable on wayland
      # this solution is copy from: https://github.com/NixOS/nixpkgs/issues/129442#issuecomment-875972207
      NIX_PROFILES = "${builtins.concatStringsSep " " (lib.reverseList config.environment.profiles)}";
      # to fix gtk application start slow problem, like waybar and clash-verge
      GTK_USE_PORTAL = "0";
    GLFW_IM_MODULE = "fcitx";
    };
  };
  services.dbus.enable = true;

  fonts = {
    fontconfig = {
      enable = true;
      hinting = {
        enable = true;
        autohint = false;
        # hintstyle = "hintslight(10px,12px)";
      };
      defaultFonts.emoji = [
        "Twitter Color Emoji"
        "Noto Color Emoji"
      ];
      defaultFonts.monospace = [
        "LXGW WenKai Mono"
        "UbuntuMono Nerd Font Mono"
        "Symbols Nerd Font"
        "Noto Sans CJK SC"
        "Sarasa Mono SC"
      ];
      defaultFonts.sansSerif = [
        "LXGW WenKai Mono"
        "Noto Sans CJK SC"
        "DejaVu Sans"
      ];
      defaultFonts.serif = [
        "LXGW WenKai Mono"
        "Noto Sans CJK SC"
      ];

      localConf = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>
          <!-- Use language-specific font variants. -->
          ${lib.concatMapStringsSep "\n"
            (
              { lang, variant }:
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
              in
              replace "Noto Sans CJK SC" "Noto Sans CJK ${variant}"
              + replace "Noto Serif CJK SC" "Noto Serif CJK ${variant}"
            )
            [
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
    packages =
      (with pkgs; [
        fira
        fira-code
        # symbola # 特殊字符
        jetbrains-mono
        font-awesome

        noto-fonts-color-emoji
        rofi-emoji
        twitter-color-emoji
        unicode-emoji
        vista-fonts # many windows font(include consolas)
        # maple-mono-NF
        monego

        cascadia-code
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        # sarasa-gothic
        noto-fonts
        wqy_microhei
        wqy_zenhei
        lxgw-wenkai
        intel-one-mono
        icursive-nerd-font

        maple-mono.NF
        maple-mono.CN
      ])
      ++ [
        pkgs.nerd-fonts.fira-code
        pkgs.nerd-fonts.fira-mono
        pkgs.nerd-fonts.ubuntu-mono
        pkgs.nerd-fonts.symbols-only
        pkgs.nerd-fonts.hack
      ];
  };
}
