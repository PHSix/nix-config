{
  lib,
  username,
  config,
  ...
}:
let
  types = lib.types;
in
{
  options.hmModules = lib.mkOption {
    type = types.listOf lib.types.unspecified;
    default = [ ];
    description = "List of Home Manager modules";
  };
  config = {
    home-manager.users."${username}" = hm-inputs: {
      imports = [
        {
          home.stateVersion = hm-inputs.lib.trivial.release;
          programs.home-manager.enable = true;
        }
      ] ++ config.hmModules;
    };
  };
}
