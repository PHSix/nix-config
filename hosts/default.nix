inputs@{ ... }: {
  master = import ./master.nix inputs;
  laptop = import ./laptop.nix inputs;
}
