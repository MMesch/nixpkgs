{ pkgs ? import ./nixpkgs {}, ipython_genutils, jupyterlab_launcher, jupyterlab_server, notebook, extensions ? []}:

let
   linkerCommand = pkgs.stdenv.lib.concatMapStrings
   (s: 
   let
     dirName = "${s}/lib/node_modules/" + (builtins.replaceStrings ["node-" "_at_" "_slash_" "-${s.version}"] ["" ''@'' "/" ""] s.name);
   in ''jupyter labextension link --no-build --app-dir=$out ${dirName}'')
       extensions;
in
pkgs.stdenv.mkDerivation {
  name = "test-derivation";

  phases = [ "buildPhase" ];

  buildInputs = [ pkgs.python36Packages.jupyterlab
                  pkgs.nodejs] ++ extensions;

  propagatedBuildInputs = [
    pkgs.python36Packages.jupyterlab
  ];

  buildPhase = ''
    echo "linkerCommand:"
    echo ${linkerCommand}
    ${linkerCommand}
    jupyter lab build --app-dir=$out
    '';
}
