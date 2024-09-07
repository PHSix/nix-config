{pkgs, ...}:{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    acceleration = "rocm";
    rocmOverrideGfx = "11.0.0";

    environmentVariables = {
      OLLAMA_ORIGINS = "*";
    };
  };

}
