{ pkgs ? import
    (builtins.fetchTarball {
      url =
        "https://github.com/NixOS/nixpkgs/archive/989a2b93b79dd0553028e83be5f5db7221476d76.tar.gz";
    })
    { }
}:
let
  alpineImage = pkgs.dockerTools.pullImage {
    imageName = "alpine";
    imageDigest =
      "sha256:25fad2a32ad1f6f510e528448ae1ec69a28ef81916a004d3629874104f8a7f70";
    sha256 = "sha256-ymburWdn08/l5jqTAmdeXbBys0q01OmNuOVG4mnMzqk=";
  };
in
pkgs.dockerTools.buildImage {
  name = "psibi/alpine-haskell-stack";
  tag = "v3";

  fromImage = alpineImage;

  contents = [
    pkgs.pkgsMusl.haskell.compiler.ghc945
    pkgs.pkgsMusl.zlib
    pkgs.pkgsMusl.zlib.dev
    pkgs.pkgsMusl.ncurses
  ];

  config = { Cmd = [ "/bin/sh" ]; };
}
