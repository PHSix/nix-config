{ pkgs, ... }:
let username = "ph";
in
{
  security.doas.enable = true;
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "dialout" "docker" ];
    # set the default shell is zsh shell
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
}
