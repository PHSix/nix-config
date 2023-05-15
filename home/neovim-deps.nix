{ pkgs, ... }:
{
  # home.packages = with pkgs.python311Packages; [
  #   python-lsp-server
  #   pylsp-mypy
  #   pyls-isort
  #   python-lsp-black
  #   python-lsp-ruff
  # ];
  home.packages = with pkgs.python310Packages; [
    autopep8
  ];
}
