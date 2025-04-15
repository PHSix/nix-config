inputs@{
  pkgs,
  username,
  ...
}:
let
  shell = if builtins.hasAttr "shell" inputs then inputs.shell else pkgs.fish;
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
    inherit shell;
  };
  programs.zsh.enable = true;
  programs.fish.enable = true;

  networking.firewall.enable = false;

  hmModules = [ misc ];
}
