{ pkgs, ... }: {
  home.packages = with pkgs; [
    google-chrome
    # clash-verge
    clash-verge-rev
    v2raya
    clash-meta
    microsoft-edge
    vscode-fhs
    flameshot
    vlc
    git-butler
  ];
}
