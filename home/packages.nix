{ pkgs, ... }: {
  home.packages = with pkgs; [
    google-chrome
    clash-verge
    clash-meta
    microsoft-edge
    # vscode-fhs
    flameshot
  ];
}
