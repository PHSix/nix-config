{ pkgs, ... }: {
  home.packages = with pkgs; [
    google-chrome
    # clash-verge
    clash-verge-rev
    v2raya
    clash-meta
    microsoft-edge-beta
    # vscode-fhs
    flameshot
    vlc
  ];
}
