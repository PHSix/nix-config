{ pkgs, config, ... }:
{
  hardware.graphics.enable = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [
    "amdgpu"
    "modesetting"
  ];

  services.xserver.modules = with pkgs.xorg; [
    xf86videoamdgpu
  ];


  hardware.graphics.extraPackages = with pkgs; [
    amdvlk
    rocmPackages.clr.icd
  ];
  # For 32 bit applications 
  hardware.graphics.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  environment.systemPackages = with pkgs; [
    vkbasalt
  ];
}
