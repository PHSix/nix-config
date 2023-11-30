#/bin/sh

echo "Launching dev's enviroment..."
nix --extra-experimental-features 'nix-command flakes' develop
