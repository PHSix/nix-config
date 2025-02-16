{ pkgs, zen-browser, system, ... }: {
  home.packages = with pkgs; [
    google-chrome
    microsoft-edge
    zen-browser.packages."${system}".default

    snipaste
    flameshot
    vlc

    vscode-fhs
    telegram-desktop
    element-desktop
    cherry-studio
    httpie-desktop
    discord
    qq

    qbittorrent

    wineWowPackages.stable
    wineWowPackages.fonts
    # wineWowPackages.waylandFull
    thunderbird

    upscayl


    jetbrains.webstorm
    # jetbrains.idea-community

    dbeaver-bin

    zig
  ];
}
