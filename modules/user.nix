{ pkgs, username, ... }:
{
  security.doas.enable = true;
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "dialout" "docker" "seat" ];
  };
}
