{ devEnv ? { }, ... }:
let
  enable = x: if builtins.hasAttr x devEnv then builtins.getAttr x devEnv else false;
  add-deps = x: deps: if enable x then deps else [ ];

  f = { pkgs, ... }:
    with pkgs;{
      home.packages =
        add-deps "python" (with pkgs;[ python313 ])
        ++ add-deps "nodejs" ([ nodejs ])
        ++ add-deps "gcc" ([ gcc gnumake cmake gccStdenv ])
        ++ add-deps "rust" ([
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
        ++ add-deps "go" ([ go ])
      ;

      home.file.".npmrc" =
        {
          text = ''
            prefix=~/.npm-packages
            registry=https://registry.npmmirror.com
          '';
        };
    };
in
{
  hmModules = [ f ];
}
