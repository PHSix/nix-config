{ lib, ... }: {
  # home = {
  #   username = user;
  #   homeDirectory = "/home/${user}";
  #   stateVersion = "22.11";
  # };

  home.stateVersion = lib.trivial.release;
  programs.home-manager.enable = true;
}
