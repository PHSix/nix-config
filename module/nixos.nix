{ ... }: {
  # nix.settings.substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
  system.stateVersion = "23.05";
  # nixpkgs.config.allowUnfree = true;
  nix = {
    # package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      flake-registry = https://cdn.jsdelivr.net/gh/NixOS/flake-registry/flake-registry.json
    '';
    settings = {
      # substituters = [
      #   "https://mirror.sjtu.edu.cn/nix-channels/store"
      # ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 5d";
      dates = "Sun 19:00";
    };
  };
  nixpkgs.config = {
    allowUnfree = true;
    allowAliases = false;
  };
  nixpkgs.system = "x86_64-linux";
}
