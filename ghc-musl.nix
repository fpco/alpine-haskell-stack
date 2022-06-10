{ pkgs ? import (builtins.fetchTarball {
  url =
    "https://github.com/NixOS/nixpkgs/archive/ce6aa13369b667ac2542593170993504932eb836.tar.gz";
}) { } }:
let
  alpineImage = pkgs.dockerTools.pullImage {
    imageName = "alpine";
    imageDigest =
      "sha256:4ff3ca91275773af45cb4b0834e12b7eb47d1c18f770a0b151381cd227f4c253";
    sha256 = "sha256:0p3jd744ndyfpz0snivx1v5nc3z7439whgg6farccgm8c3a5pjp2";
  };
in pkgs.dockerTools.buildImage {
  name = "psibi/alpine-haskell-stack";
  tag = "v2";

  fromImage = alpineImage;

  contents = [ pkgs.pkgsMusl.haskell.compiler.ghc922
               pkgs.pkgsMusl.zlib
               pkgs.pkgsMusl.zlib.dev
               pkgs.pkgsMusl.ncurses
             ];
  # contents = [ pkgs.hello ];

  config = { Cmd = [ "/bin/sh" ]; };
}
