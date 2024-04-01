#!/bin/sh

sri=$(nix-pre-fetch --type sha256 $1)

nix-hash --type sha256 --to-sri $sri
