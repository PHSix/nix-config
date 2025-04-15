inputs:
let
  hostName = if builtins.hasAttr "hostName" inputs then inputs.hostName else "nixos";
in
{
  networking = {
    inherit hostName;
    networkmanager = {
      enable = true;
    };
  };
  services.openssh.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
