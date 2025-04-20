{
  gc = "sudo nix-collect-garbage -d";
  fmt = "nixpkgs-fmt {./*.nix,./**/*.nix}";
  build = ''
    if [ -z "$1" ]; then
      echo "Usage: build <target>"
      exit 1
    fi
    echo "building $1…"
    nixos-rebuild build --flake .#$1 -L
  '';
  rebuild = ''
    if [ -z "$1" ]; then
      echo "Usage: rebuild <target>"
      exit 1
    fi
    echo "rebuilding $1 for switch…"
    sudo nixos-rebuild boot --flake .#$1 -L
  '';
  sw = ''
    if [ -z "$1" ]; then
      echo "Usage: switch <target>"
      exit 1
    fi
    echo "building and switching for $1"
    sudo nixos-rebuild switch --flake .#$1 -L
  '';
  remove-profiles = ''
    if [ -z "$1" ]; then
      echo "Usage: remove-profiles <num>"
      exit 1
    fi
    sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +$1
  '';
  list-profiles = "sudo nix-env --profile /nix/var/nix/profiles/system --list-generations";
  hash-url = "nix-prefetch-url --type sha256 $1 | nix-hash --type sha256 --to-sri";
}
