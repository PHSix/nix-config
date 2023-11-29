{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    google-chrome
    clash-verge
    clash-meta
    microsoft-edge
    vscode-fhs
    postman
    flameshot
  ];
}
