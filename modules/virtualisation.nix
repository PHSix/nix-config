{ pkgs, ... }: {
  # virtualisation.libvirtd.enable = true;
  # programs.virt-manager.enable = true;

  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };

  };
  environment.systemPackages = with pkgs; [
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    # docker-compose # start group of containers for dev
    podman-compose # start group of containers for dev

    lazydocker # docker-compose wrapper
  ];

  # enable docker service
  # virtualisation.docker.enable = true;
  # virtualisation.docker.daemon.settings = {
  #   registry-mirrors = [ "https://registry.docker-cn.com" ];
  # };

  # enable podman service
  # virtualisation.podman.enable = true;
}
