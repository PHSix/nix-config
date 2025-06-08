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
    ../../home/fish.nix
    ../../home/git.nix
    ../../home/gitui.nix
    ../../home/starship.nix
    ../../home/tmux.nix
    ../../home/vim.nix
    ../../home/yazi.nix
    ../../home/zsh.nix
  ];
}
