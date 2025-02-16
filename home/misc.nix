_: {
  programs.git = {
    enable = true;
    userName = "ph";
    userEmail = "chenyi.ph@outlook.com";
  };

  programs.gpg = { enable = true; };
  services.gpg-agent = { enable = true; };

  home.file.".rgignore".text = "
    pnpm-lock.yaml
    *.lock
  ";

  fonts.fontconfig.enable = false;
}
