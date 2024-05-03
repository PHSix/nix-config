{ lib, ... }: {
  system.stateVersion = lib.trivial.release;

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes repl-flake
      flake-registry = https://cdn.jsdelivr.net/gh/NixOS/flake-registry/flake-registry.json
    '';

    # experimental-features = [
    #   "nix-command"
    #   "flakes"
    #   "repl-flake" # can use for explain personal profile: nix repl ~/nixos-config
    # ];
    settings = {
      substituters = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 5d";
      dates = "Sun 19:00";
    };
  };
}
