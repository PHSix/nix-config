{ ... }: {
  time.timeZone = "Asia/Shanghai";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  hardware.pulseaudio.enable = true;

  # for sercet
  services.gnome.gnome-keyring.enable = true;
  environment.pathsToLink = [ "/share/zsh" ];
}
