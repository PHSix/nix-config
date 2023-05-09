{ pkgs, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  # services = {
  #   xserver.videoDrivers = [ "nvidia" ];
  # };
  # environment.systemPackages = [ nvidia-offload ];
  # hardware = {
  #   nvidia = {
  #     modesetting.enable = true;
  #     prime = {
  #       # nix-shell -p pciutils --run lspci
  #       offload.enable = true;
  #       intelBusId = "PCI:0:2:0";
  #       nvidiaBusId = "PCI:1:0:0";
  #     };
  #   };

  # };

  # override enable graphics hybrid mode
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}
