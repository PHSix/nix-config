inputs@{ pkgs, ... }:
{
  imports = [
    inputs.maomaowm.hmModules.maomaowm
  ];

  wayland.windowManager.maomaowm = {
    enable = true;
    settings = ''
      # see config.conf
    '';
    autostart_sh = ''
      # see autostart.sh
      # Note: here no need to add shebang
    '';
  };
}
