{ pkgs, ... }: {
  home.packages = with pkgs; [
    google-chrome
    clash-verge
    v2raya
    clash-meta
    microsoft-edge
    # vscode-fhs
    flameshot
  ];
}
