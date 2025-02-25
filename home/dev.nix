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

  home.file.".npmrc" =
    {
      text = ''
        prefix=~/.npm-packages
        registry=https://registry.npmmirror.com
      '';
    };
}


