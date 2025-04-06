{ pkgs, ... }:
{
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      extraConfig = ''GRUB_CMDLINE_LINUX_DEFAULT="quiet splash usbcore.autosuspend=-1"'';

      useOSProber = true;
    };
    efi = {
      canTouchEfiVariables = true;
    };
  };
  boot.consoleLogLevel = 1;
  # boot.kernelParams = ["quiet" "splash" "usbcore.autosuspend=-1"];

  # boot.kernelParams = [ "amdgpu.backlight=0" "acpi_backlight=none" ];
  # boot.kernelParams = [ "amdgpu.backlight=0" "acpi_backlight=video" ];
  boot.kernelParams = [ "acpi_backlight=video" ];

  environment.systemPackages = with pkgs; [ ntfs3g ];

}
