{ pkgs, ... }:
let
  py-deps = pkgs.python313.withPackages (
    py-pkgs:
    (with py-pkgs; [
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
    ])
  );
in
{
  programs.emacs.enable = true;
  services.emacs.enable = true;
  programs.emacs.extraPackages = (
    epkgs: with pkgs; [
      py-deps
      typescript

      typescript-language-server
      nixpkgs-fmt
      vscode-langservers-extracted
    ]
  );
}
