{ pkgs, zen-browser, system, ... }: {
  home.packages = with pkgs; [
    google-chrome
    clash-verge-rev
    v2raya
    # clash-meta
    # microsoft-edge
    zen-browser.packages."${system}".default

    vscode-fhs
    gopls
    flameshot
    vlc

    telegram-desktop
    element-desktop

    # feishu
    qq
    qbittorrent

    wineWowPackages.stable
    wineWowPackages.fonts
    # wineWowPackages.waylandFull
    thunderbird

    upscayl

    # jetbrains.idea-community

    dbeaver-bin

  ];
}
