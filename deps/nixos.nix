{
  lib,
  username,
  ...
}:
{
  system.stateVersion = lib.trivial.release;

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      flake-registry = https://cdn.jsdelivr.net/gh/NixOS/flake-registry/flake-registry.json
    '';

    settings = {
      substituters = [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
      ];

      trusted-users = [
        "root"
        username
      ];

    };
    gc = {
      automatic = true;
      options = "--delete-older-than 5d";
      dates = "Sun 19:00";
    };
  };
}
