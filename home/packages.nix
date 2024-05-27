{ pkgs, ... }: {
  home.packages = with pkgs; [
    google-chrome
    clash-verge-rev
    v2raya
    # clash-meta
    microsoft-edge
    vscode-fhs
    flameshot
    vlc

    telegram-desktop

    # feishu
    qq
    qbittorrent
    # zed-editor
  ];
}
