{ vimUtils, fetchFromGitHub }:

vimUtils.buildVimPlugin {
  pname = "hlsearch.nvim";
  version = "main";
  src = fetchFromGitHub {
    owner = "nvimdev";
    repo = "hlsearch.nvim";
    rev = "fdeb60b890d15d9194e8600042e5232ef8c29b0e";
    hash = "sha256-ibizMO16T/SwZIcl+zckbpDHMYQovKPEB5iO2YBRj74=";
  };
  meta.homepage = "https://github.com/nvimdev/hlsearch.nvim";
}

