{ pkgs, ... }:
{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    # docker = {
    #   enable = true;
    #   settings = {
    #     registry-mirrors = [ "https://registry.docker-cn.com" ];
    #   };
    # };

  };
  environment.systemPackages = with pkgs; [
    dive
    podman-tui
    podman-compose

    lazydocker
  ];
}
