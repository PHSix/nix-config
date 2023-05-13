{ ... }: {
  time.timeZone = "Asia/Shanghai";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # sound config
  sound.enable = true;
  hardware.pulseaudio.enable = true;


  # enable docker service
  virtualisation.docker.enable = true;
  # virtualisation.docker.daemon.settings = {
  #   registry-mirrors = [ "https://registry.docker-cn.com" ];
  # };

  environment.pathsToLink = [ "/share/zsh" ];
}
