{ pkgs, username, ... }:
let
  misc = _: {
    programs.git = {
      enable = true;
      userName = username;
      userEmail = "chenyi.ph@outlook.com";

      extraConfig = {
        pull.rebase = false;
      };

    };

    programs.gpg = {
      enable = true;
    };
    services.gpg-agent = {
      enable = true;
    };

    home.file.".rgignore".source = ../config/rgignore;

    fonts.fontconfig.enable = false;
  };
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
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  programs.fish.enable = true;

  networking.firewall.enable = false;

  hmModules = [ misc ];
}
