{ pkgs, ... }:
{
  virtualisation = {
    # podman = {
    #   enable = true;
    #   dockerCompat = true;
    #   defaultNetwork.settings.dns_enabled = true;
    # };

    docker = {
      enable = true;
    };
  };
  environment.systemPackages = with pkgs; [
    dive

    lazydocker
  ];
}
