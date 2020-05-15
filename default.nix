{ pkgs ? import ./nix/pkgs.nix }:
let
  drv = { stdenv, fetchFromGitHub, autoreconfHook, pkgconfig, varnish, docutils
    , removeReferencesTo, nix-gitignore }:

    stdenv.mkDerivation rec {
      pname = "libvmod-example";
      version = "0.0.1";

      src = nix-gitignore.gitignoreSource [ "/nix/" "*.nix" ] ./.;

      nativeBuildInputs = [
        autoreconfHook
        docutils
        pkgconfig
        removeReferencesTo
        varnish.python # use same python version as varnish server
      ];

      buildInputs = [ varnish ];

      VARNISHAPI_DATAROOTDIR = "${varnish.dev}/share";

      # postInstall =
      #   "find $out -type f -exec remove-references-to -t ${varnish.dev} '{}' +"; # varnish.dev captured only as __FILE__ in assert messages

      # meta = with stdenv.lib; {
      #   description =
      #     "Collection of Varnish Cache modules (vmods) by Varnish Software";
      #   homepage = "https://github.com/varnish/varnish-modules";
      #   inherit (varnish.meta) license platforms maintainers;
      # };
    };
in pkgs.callPackage drv { }
