{ vimUtils, fetchFromGitHub }:

vimUtils.buildVimPlugin {
  pname = "fcitx-nvim";
  version = "main";
  src = fetchFromGitHub {
    owner = "h-hg";
    repo = "fcitx.nvim";
    rev = "dcb6b70888aa893d3d223bb777d4117bbdac06a7";
    hash = "sha256-Fa3BrXmDYF135Fv4FV+Zjv1mdgD9UdqON2FJxOHkkUI=";
  };
  meta.homepage = "https://github.com/h-hg/fcitx-nvim";
}

