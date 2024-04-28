#!/bin/sh

shell=$(basename $SHELL)

echo "Launching dev's enviroment..."
nix --extra-experimental-features 'nix-command flakes' develop --command $shell
