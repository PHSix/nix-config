{
  username,
  ...
}:
{

  home.username = username;

  home.homeDirectory = "/home/${username}";

  imports = [
    ../../home/cli.nix
    ../../home/dev.nix
    ../../home/fish.nix
    ../../home/git.nix
    ../../home/gitui.nix
    ../../home/packages.nix
    ../../home/starship.nix
    ../../home/tmux.nix
    ../../home/vim.nix
    ../../home/yazi.nix
    ../../home/zsh.nix
  ];
}
