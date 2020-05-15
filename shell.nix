{ pkgs ? import ./nix/pkgs.nix }:

let
  inherit (pkgs) mkShell varnish;
  drv = import ./. { inherit pkgs; };

in pkgs.mkShell {
  inputsFrom = [ drv ];
  VARNISHAPI_DATAROOTDIR = "${varnish.dev}/share";
}
