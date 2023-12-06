inputs@{ ... }: {
  master = import ./master.nix inputs;
  laptop = import ./laptop.nix inputs;
  orb-vm = import ./orb-vm.nix inputs;
}
