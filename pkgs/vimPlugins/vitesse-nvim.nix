{ vimUtils, fetchFromGitHub, platforms,... }:

vimUtils.buildVimPlugin {
  pname = "vitesse-nvim";
  version = "main";
  src = fetchFromGitHub {
    owner = "PHSix";
    repo = "vitesse.nvim";
    rev = "3ce038791ac3270ae8860c469f0551e523ce836a";
    hash = "sha256-E7VedrlCMXYWNJZ1Dwxto2OTbuxDBYtjMClcgtMHa50=";
  };

  nvimSkipModule = [
    "vitesse.plugins.nvim-tree"
  ];

  meta.homepage = "https://github.com/PHSix/vitesse.nvim";
}

