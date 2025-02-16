_: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      font-size = 12;
      confirm-close-surface = false;
      keybind = [
        "ctrl+enter=unbind"
      ];
    };
  };
}
