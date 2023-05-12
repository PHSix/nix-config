# source code url: https://github.com/nix-community/home-manager/blob/master/modules/services/mpd.nix
{ pkgs, ... }:
{
  services.mpd = {
    enable = true;
    musicDirectory = "~/Music/Local";
    extraConfig = ''
      audio_output {
        type "pulse"
        name "MPD PulseAudio" # this can be whatever you want
      }
    '';


    network.startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
  };
  home.packages = with pkgs; [ ncmpcpp ];
}
