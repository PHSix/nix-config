{ lib, ... }: {
  home.stateVersion = lib.trivial.release;
  programs.home-manager.enable = true;
}
