# release the disk for free
gc:
	sudo nix-collect-garbage -d

# format the repo nix file code
fmt:
	nixpkgs-fmt {./*.nix,./**/*.nix}

# Test build a nixos flake output.
build target:
	@echo 'building {{target}}…'
	nixos-rebuild build --flake {{target}} -L

# rebuild nixos for boot
rebuild target:
	@echo 'rebuilding {{target}} for boot…'
	sudo -E nixos-rebuild boot --flake {{target}}

# rebuild and switch
switch target:
	@echo 'building and switching for {{target}}'
	sudo -E nixos-rebuild switch --flake {{target}} -L

# delete nix profile as least {{num}}
remove-profiles num:
	sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +{{num}}

# list all of nix profiles
list-profiles:
	sudo nix-env --profile /nix/var/nix/profiles/system --list-generations

# set proxy for nix-daemon
daemon-proxy:
	sudo sh ./scripts/daemon-proxy.sh

#calc hash file from url
hash-url:
	sudo sh ./scripts/hash.sh
