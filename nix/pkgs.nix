let
  sources = import ./sources.nix;
  varnishFix = self: super: {
    varnish = super.varnish.overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [
        (super.fetchpatch {
          url =
            "https://patch-diff.githubusercontent.com/raw/varnishcache/varnish-cache/pull/3327.diff";
          sha256 = "1lnfngjds1iyw4nml17jkhj5k0ny3cqni9ikgrbbm186l528l91f";
        })
      ];
    });
  };
in import sources.nixpkgs { overlays = [ varnishFix ]; }
