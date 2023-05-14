{ ... }: {
  services = {
    mpd = {
      enable = true;
      musicDirectory = "/home/ph/Music";
      extraConfig = ''
        audio_output {
          type "pulse"
          name "My PulseAudio"
        }
      '';
    };
  };
}

