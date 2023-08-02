# source code url: https://github.com/nix-community/home-manager/blob/master/modules/services/mpd.nix
{ ... }: {
  programs.ncmpcpp = {
    enable = true;
    mpdMusicDir = "~/Music";
  };
  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
    extraConfig = ''
      audio_output {
        type "pulse"
        name "MPD PulseAudio" # this can be whatever you want
      }
      auto_update             "yes"
      auto_update_depth       "4"
    '';
  };
}
