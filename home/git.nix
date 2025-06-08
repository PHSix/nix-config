{ username, ... }:
{
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
}
