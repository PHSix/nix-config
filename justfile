# release the disk for free
gc:
		sudo nix-collect-garbage -d

# format the repo nix file code
fmt:
		nixpkgs-fmt {./*.nix,./**/*.nix}

# Test build a nixos flake output.
build target:
		@echo 'Building {{target}}…'
		nixos-rebuild build --flake {{target}}

# rebuild nixos for boot
rebuild target:
		@echo 'Re-Building {{target}} for boot…'
		sudo -E nixos-rebuild boot --flake "$1"

# rebuild and switch
switch target:
		@echo 'Build and switch for {{target}}'
		sudo -E nixos-rebuild switch --flake {{target}}

# delete nix profile as least {{num}}
remove-profiles num:
		sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +{{num}}

# list all of nix profiles
list-profiles:
		sudo nix-env --profile /nix/var/nix/profiles/system --list-generations
