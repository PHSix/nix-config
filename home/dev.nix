{ usePython ? true
, useJs ? true
, useGcc ? true
, useRust ? false
, useGo ? false
}:
let
  f = state: packages: if state then packages else [ ];
in
{ pkgs, ... }: {
  home.packages = f usePython (with pkgs;[ python313 ])
    ++ f useJs (with pkgs; [ nodejs deno ])
    ++ f useGcc (with pkgs; [ gcc gnumake cmake gccStdenv ])
    ++ f useRust (with pkgs; [

    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    cargo-generate
    wasm-pack
    rust-analyzer-nightly
  ])
    ++ f useGo (with pkgs; [ go ])
  ;

  home.file.".cargo/config.toml" = {
    text = ''
      [source.crates-io]
      replace-with = 'rsproxy-sparse'
      [source.rsproxy]
      registry = "https://rsproxy.cn/crates.io-index"
      [source.rsproxy-sparse]
      registry = "sparse+https://rsproxy.cn/index/"
      [registries.rsproxy]
      index = "https://rsproxy.cn/crates.io-index"
      [net]
      git-fetch-with-cli = true
    '';
  };
  home.file.".npmrc" =
    {
      text = ''
        prefix=~/.npm-packages
        registry=https://registry.npmmirror.com
      '';
    };
}


