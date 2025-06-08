{
  pkgs,
  zen-browser,
  system,
  ...
}:
{
  home.packages = with pkgs; [
    # browser
    google-chrome
    chromium
    puppeteer-cli
    firefox
    zen-browser.packages.${system}.default

    snipaste
    flameshot
    vlc

    # electron apps
    vscode-fhs
    windsurf
    cherry-studio
    httpie-desktop
    discord
    qq
    telegram-desktop
    element-desktop
    feishu
    bilibili
    # qqmusic
    bruno

    qbittorrent

    wineWowPackages.stable
    wineWowPackages.fonts

    # jb ide
    jetbrains.webstorm
    jetbrains.idea-community

    warp-terminal
    alacritty
  ];
}
