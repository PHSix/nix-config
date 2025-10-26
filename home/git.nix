{ username, ... }:
{
  programs.git = {
    enable = true;

    settings = {
      pull.rebase = false;
      user = {
        name = username;
        email = "chenyi.ph@outlook.com";
      };
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
