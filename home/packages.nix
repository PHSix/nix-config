{ pkgs, ... }: {
  home.packages = with pkgs; [
    google-chrome
    clash-verge-rev
    v2raya
    # clash-meta
    microsoft-edge
    vscode-fhs
    gopls
    flameshot
    vlc

    telegram-desktop

    # feishu
    qq
    qbittorrent

    wineWowPackages.stable
    wineWowPackages.fonts
    # wineWowPackages.waylandFull
    thunderbird

    upscayl

    jetbrains.idea-community
  ];
}
