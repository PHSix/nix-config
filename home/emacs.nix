{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
  };

  services.emacs.enable = true;

  home.packages = with pkgs; [
    libtool
    cmake
  ];
}
