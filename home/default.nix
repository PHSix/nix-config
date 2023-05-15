{ ... }:
{
  # home = {
  #   username = user;
  #   homeDirectory = "/home/${user}";
  #   stateVersion = "22.11";
  # };

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
