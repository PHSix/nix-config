{
  hmModules = [
    (_: {
      programs.ghostty = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          font-size = 12;
          confirm-close-surface = false;
          cursor-style-blink = false;
          theme = "catppuccin-mocha";
          keybind = [
            "ctrl+enter=unbind"
          ];
        };
      };
    })
  ];
}

