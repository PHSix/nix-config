{...}: {
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      extraConfig = "GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash usbcore.autosuspend=-1\"";
    };
    efi = {
      canTouchEfiVariables = true;
    };
  };
  boot.consoleLogLevel = 1;
  # boot.kernelParams = ["quiet" "splash" "usbcore.autosuspend=-1"];
}
