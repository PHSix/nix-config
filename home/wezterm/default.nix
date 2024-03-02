{ pkgs, ... }: {
  programs.wezterm = {
    enable = true;
    package = pkgs.wezterm;
    extraConfig = builtins.readFile ./wezterm.lua;
  };

  # home.file.".config/wezterm/wezterm.lua".source = ./wezterm.lua;
}
