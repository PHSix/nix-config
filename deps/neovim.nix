{ nvim-flake, system, ... }:
{
  environment.systemPackages = [ nvim-flake.packages.${system}.neovim ];
}
