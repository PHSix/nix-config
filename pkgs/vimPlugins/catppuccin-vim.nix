{ vimUtils, fetchFromGitHub }:

vimUtils.buildVimPluginFrom2Nix {
  pname = "catppuccin.vim";
  version = "2023-1-22";
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "vim";
    rev = "cf186cffa9b3b896b03e94247ac4b56994a09e34";
    sha256 = "1rvlx21kw8865dg6q97hx9i2s1n8mn1nyhn0m7dkx625pghsx3js";
  };
  meta.homepage = "https://github.com/catppuccin/vim";
}

