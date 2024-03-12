{ vimUtils, fetchFromGitHub }:

vimUtils.buildVimPlugin {
  pname = "catppuccin.vim";
  version = "2023-1-22";
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "vim";
    rev = "cf186cffa9b3b896b03e94247ac4b56994a09e34";
    hash = "sha256-G3RLkRu6+A6E9b5rHpo9yJwnfkkPon/AkXqQUz8YsZ0=";
  };
  meta.homepage = "https://github.com/catppuccin/vim";
}

