{ rustPlatform, fetchgit, lib }:
rustPlatform.buildRustPackage rec {
  pname = "wl-clip-persist";
  version = "0.3.1";

  src = fetchgit {
    url = "https://github.com/Linus789/${pname}";
    rev = "6ba11a2aa295d780f0b2e8f005cf176601d153b0";
    sha256 = "sha256-wg4xEXLAZpWflFejP7ob4cnmRvo9d/0dL9hceG+RUr0=";
    # owner = "Linus789";
    # repo = pname;
    # rev = "main";
  };
  cargoSha256 = "sha256-vNxNvJ5tA323EVArJ6glNslkq/Q6u7NsIpTYO1Q3GEw=";

  cargoInstallHook = ''
    echo "cargo install hook: "
    ls
    pwd
  '';
  # cargoSha256 = lib.fakeSha256;
}
