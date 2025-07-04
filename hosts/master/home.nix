{
  username,
  ...
}:
{

  home.username = username;

  home.homeDirectory = "/home/${username}";

  home.stateVersion = "25.05";

  imports = [
    ../../home/cli.nix
    ../../home/dev.nix
    ../../home/emacs.nix
    ../../home/fish.nix
    # ../../home/ghostty.nix
    ../../home/git.nix
    ../../home/gitui.nix
    ../../home/kitty.nix
    ../../home/packages.nix
    ../../home/rofi.nix
    ../../home/starship.nix
    ../../home/tmux.nix
    ../../home/vim.nix
    ../../home/yazi.nix
    ../../home/zsh.nix
  ];
}
