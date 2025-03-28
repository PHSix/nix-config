_: {

  hmModules = [
    (_: {
      programs.starship = {
        enable = true;
        enableBashIntegration = false;
        enableZshIntegration = true;
      };
    })
  ];
}
