{
  pkgs,
  config,
  ...
}:
let
  aikadm = pkgs.aikadm;
  out = config.services.displayManager.sessionData.desktops.out;
  argv = {
    sessionDir = [
      (builtins.trace "aikadm out: ${out}" out)
    ];
  };
  cmd = "${aikadm.cmdWithArgs argv}";
in
{
  services = {
    greetd = {
      enable = true;
      settings.default_session = {
        command = cmd;
        user = "greeter";
      };
    };

    displayManager = {
      defaultSession = "plasma";
    };
  };
}
