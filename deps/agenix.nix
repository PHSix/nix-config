{ agenix, system, username, config, ... }:
{
  age.identityPaths = [ "/home/${username}/.age/key.txt" ];
  age.secrets.dae.file = ../secrets/dae.age;
  age.secrets.zshLocal.file = ../secrets/zshLocal.age;
  age.secrets.zshLocal.mode = "777";
  environment.systemPackages = [
    agenix.packages.${system}.default
  ];
  environment.etc."zshrc.local".source = config.age.secrets.zshLocal.path;
}

