{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    google-chrome
    clash-verge
    microsoft-edge
    # vscode-fhs
    postman
    flameshot
    # apifox
    # alacritty
    # microsoft-edge
  ];
}
