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
  services.gpg-agent = { enable = true; };

  home.file.".rgignore".text = "
		pnpm-lock.yaml
		*.lock
	";

  # xdg.configFile."user-dirs.dirs".text = ''
  #   # This file is written by xdg-user-dirs-update
  #   # If you want to change or add directories, just edit the line you're
  #   # interested in. All local changes will be retained on the next run.
  #   # Format is XDG_xxx_DIR="$HOME/yyy", where yyy is a shell-escaped
  #   # homedir-relative path, or XDG_xxx_DIR="/yyy", where /yyy is an
  #   # absolute path. No other format is supported.
  #   # 
  #   XDG_DESKTOP_DIR="$HOME/Desktop"
  #   XDG_DOWNLOAD_DIR="$HOME/Downloads"
  #   XDG_TEMPLATES_DIR="$HOME/Template"
  #   XDG_PUBLICSHARE_DIR="$HOME/Public"
  #   XDG_DOCUMENTS_DIR="$HOME/Documents"
  #   XDG_MUSIC_DIR="$HOME/Music"
  #   XDG_PICTURES_DIR="$HOME/Picture"
  #   XDG_VIDEOS_DIR="$HOME/Video"
  # '';
  #
  # home.file.".ssh/config".text = ''
  #   Host github.com
  #   Hostname ssh.github.com
  #   Port 443
  #   User git
  # '';

  fonts.fontconfig.enable = false;
}
