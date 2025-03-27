{
  pkgs,
  zen-browser,
  system,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    firefox
    xplorer
    pkg-config

    git # important, for nix flake dependence
    kitty # for default terminal

    devenv
  ];

  hmModules = [
    (
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          # browser
          google-chrome
          zen-browser.packages.${system}.default
          zen-browser

          snipaste
          flameshot
          vlc

          # electron apps
          vscode-fhs
          cherry-studio
          httpie-desktop
          discord
          qq
          telegram-desktop
          element-desktop
          feishu
          github-desktop

          qbittorrent

          wineWowPackages.stable
          wineWowPackages.fonts

          # jb ide
          jetbrains.webstorm
          jetbrains.idea-community

          warp-terminal
        ];
      }
    )
  ];
}
