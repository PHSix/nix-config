{ pkgs, config, ... }:
let
  amdgpu-pro = config.boot.kernelPackages.amdgpu-pro;
in
{
  hardware.opengl.enable = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [
    "amdgpu"
    "modesetting"
  ];

  services.xserver.modules = with pkgs.xorg; [
    xf86videoamdgpu
  ];

  boot.extraModulePackages = [
    amdgpu-pro
  ];

  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
    rocmPackages.clr.icd
  ];
  # For 32 bit applications 
  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  hardware.opengl.driSupport = true; # This is already enabled by default
  hardware.opengl.driSupport32Bit = true; # For 32 bit applications

  environment.systemPackages = with pkgs; [
    amdgpu-pro
    vkbasalt
  ];
}
