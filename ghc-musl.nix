{ pkgs ? import
    (builtins.fetchTarball {
      url =
        "https://github.com/NixOS/nixpkgs/archive/81d5cb1550ef0a58c5ee529c743065cc93a7fb64.tar.gz";
    })
    { }
}:
let
  alpineImage = pkgs.dockerTools.pullImage {
    imageName = "alpine";
    imageDigest =
      "sha256:e2e16842c9b54d985bf1ef9242a313f36b856181f188de21313820e177002501";
    sha256 = "sha256-YCYpUByIOig4zt/WIvDas3AwHjDYkIQJ6IEKuADJmgg=";
  };
in
pkgs.dockerTools.buildImage {
  name = "psibi/alpine-haskell-stack";
  tag = "v3";

  fromImage = alpineImage;

  contents = [
    pkgs.pkgsMusl.haskell.compiler.ghc927
    pkgs.pkgsMusl.zlib
    pkgs.pkgsMusl.zlib.dev
    pkgs.pkgsMusl.ncurses
  ];

  config = { Cmd = [ "/bin/sh" ]; };
}
