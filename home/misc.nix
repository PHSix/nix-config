{ ... }: {

  # for git config
  programs.git = {
    enable = true;
    userName = "ph";
    userEmail = "chenyi.ph@outlook.com";
    # signing = {
    #   key = "db798e717a8622fa158d58552f2c7309f0bf7ed84fabd9d09a77c83a23b29fe7";
    #   signByDefault = true;
    # };
    extraConfig = {
      # http = {
      #   proxy = "http://localhost:7890";

      # };
      # https = { proxy = "http://localhost:7890"; };
    };
  };

  programs.gpg = { enable = true; };
  # services.gpg-agent = { enable = true; };

  # xdg.configFile."user-dirs.dirs".source = ./user-dirs.dirs;

  home.file.".ssh/config".text = ''
    Host github.com
    Hostname ssh.github.com
    Port 443
    User git
  '';
}
