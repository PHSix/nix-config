inputs@{ ... }:
{
  master = import ./master/default.nix inputs;
  orb-vm = import ./orb-vm.nix inputs;
  wsl = import ./wsl.nix inputs;
  ilya = import ./ilya.nix inputs;
}
