{ agenix, system, username, ... }:
{
  age.identityPaths = [ "/home/${username}/.age/key.txt" ];
  age.secrets.dae.file = ../secrets/dae.age;
  age.secrets.env.file = ../secrets/env.age;
  age.secrets.env.mode = "777";
  environment.systemPackages = [
    agenix.packages.${system}.default
  ];
}

