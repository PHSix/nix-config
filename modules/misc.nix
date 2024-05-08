{ ... }: {
  time.timeZone = "Asia/Shanghai";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # sound config
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # for sercet
  services.gnome.gnome-keyring.enable = true;
  environment.pathsToLink = [ "/share/zsh" ];
}
