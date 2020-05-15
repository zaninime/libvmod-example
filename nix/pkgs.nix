let
  sources = import ./sources.nix;
  varnishFix = self: super: {
    varnish = super.varnish.overrideAttrs (old: {
      postPatch = (old.postPatch or "") + ''
        substituteInPlace bin/varnishtest/vtc_main.c --replace "/bin/" ""
        substituteInPlace bin/varnishtest/vtc_process.c --replace "/bin/" ""
      '';
    });
  };
in import sources.nixpkgs { overlays = [ varnishFix ]; }
