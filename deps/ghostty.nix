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
          shell-integration = "none";
          shell-integration-features = "no-cursor,sudo,title";
          keybind = [ "ctrl+enter=unbind" ];
        };
      };
    })
  ];
}
