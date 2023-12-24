{ lib, config, ... }:
with lib;
let
  cfg = config.programs.desktop;
in
{
  options = {
    programs.desktop =
      {
        enable = mkEnableOption "the desktop program";
        type = mkOption {
          type = types.enum [ "hyprland" "gnome" "wayfire" "plasma" ];

          description = "A desktop option";

          default = "plasma";
        };

        specifyInputs = mkOption {
          type = types.attrs;
          default = { };
        };
      };
  };

  config = mkIf cfg.enable {
    import = [ ];
  };
}
