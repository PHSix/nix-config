{ pkgs
, usePython ? true
, useNodejs ? true
, useGcc ? true
, useRust ? false
, useGo ? false
, ...
}:
let
  f = state: packages: if state then packages else [ ];
in
{
  home.packages = f usePython (with pkgs;[ python311 ])
    ++ f useNodejs (with pkgs; [ nodejs ])
    ++ f useGcc (with pkgs; [ gcc gnumake cmake gccStdenv ])
    ++ f useRust (with pkgs; [ rustc cargo ])
    ++ f useGo (with pkgs; [ go ])
  ;
}
