{ pkgs, ... }:
let
  py = pkgs.python313.withPackages
    (py-pkgs: (with py-pkgs; [
      autopep8
      black
      python-lsp-server
      epc
      orjson
      sexpdata
      six
      setuptools
      paramiko
      rapidfuzz
      watchdog
    ]));
in
{
  programs.emacs.enable = true;
  services.emacs.enable = true;
  programs.emacs.extraPackages = (epkgs: with pkgs; [
    py
    typescript

    typescript-language-server
    nixpkgs-fmt
    vscode-langservers-extracted
  ]);
}
