{ ... }: {

  # for git config
  programs.git = {
    enable = true;
    userName = "ph";
    userEmail = "chenyi.ph@outlook.com";
  };

  programs.gpg = { enable = true; };
  services.gpg-agent = { enable = true; };

  #  home.file.".rgignore".text = "
  # 	pnpm-lock.yaml
  # 	*.lock
  # ";

  # home.file.".ssh/config".text = ''
  #   Host github.com
  #   Hostname ssh.github.com
  #   Port 443
  #   User git
  # '';

  fonts.fontconfig.enable = false;
}
