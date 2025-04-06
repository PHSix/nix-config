_: {
  networking = {
    hostName = "nixos";
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
