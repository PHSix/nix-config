{
  hmModules = [
    (
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          nix-tree
          htop
          wget
          xsel
          ripgrep
          fzf
          fd
          delta
          eza
          tree
          zoxide
          sqlite
          lazygit
          ranger
          yazi
          w3m
          jq
          fx
          neofetch
          fastfetch
          bat
          just
          nixpkgs-fmt
          nix-output-monitor
          unrar

          # some nix cli utils tool
          nurl
          mpv

          # termusic

          aider-chat
        ];
      }
    )
  ];
}
