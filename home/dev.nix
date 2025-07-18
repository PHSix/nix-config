{
  pkgs,
  devEnv ? { },
  ...
}:
with pkgs;
let
  enable = x: if builtins.hasAttr x devEnv then builtins.getAttr x devEnv else false;
  add-deps = x: deps: if enable x then deps else [ ];
in

{
  home.packages =
    add-deps "python" (with pkgs; [ python313 ])
    ++ add-deps "nodejs" [ nodejs ]
    ++ add-deps "deno" [ deno ]
    ++ add-deps "gcc" [
      gcc
      gnumake
      cmake
      gccStdenv
    ]
    ++ add-deps "rust" [
      (rust-bin.stable.latest.default.override {
        extensions = [
          "rust-src"
          "rust-analyzer"
          "rustfmt"
          "clippy"
          "cargo"
          "rustc"
        ];
        targets = [
          "x86_64-unknown-linux-gnu"
          "wasm32-unknown-unknown"
        ];
      })
    ]
    ++ add-deps "go" [ go ]
    ++ add-deps "ocaml" [
      ocaml
      opam
    ]
    ++ add-deps "kotlin" [
      gradle
      jdk21
      kotlin
    ];

}
