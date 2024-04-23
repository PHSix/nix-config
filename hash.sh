#!/bin/sh

sri=$(nix-prefetch-url --type sha256 $1)

nix-hash --type sha256 --to-sri $sri
