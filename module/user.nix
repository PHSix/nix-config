{ pkgs, ... }:
let username = "ph";
in
{
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "dialout" "docker" ];
    packages = with pkgs; [
    ];
    # set the default shell is zsh shell
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
}
