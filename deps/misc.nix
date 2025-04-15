{ ... }:
{
  time.timeZone = "Asia/Shanghai";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # for sercet
  environment.pathsToLink = [ "/share/zsh" ];
}
