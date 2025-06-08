inputs@{
  pkgs,
  username,
  ...
}:
let
  shell = if builtins.hasAttr "shell" inputs then inputs.shell else pkgs.zsh;
in
{
  security.doas.enable = true;
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "docker"
      "seat"
      "libvirtd"
      "adbusers"
    ];
    inherit shell;
  };
  programs.zsh.enable = true;
  programs.fish.enable = true;

  networking.firewall.enable = false;
}
