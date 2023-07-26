{ pkgs, inputs, ... }:

let myHaskellPackages = 
      pkgs.haskell.packages.ghc96.override (old: {
        overrides = pkgs.lib.composeExtensions (old.overrides or (_: _: {})) 
          (hself: hsuper: {
            ghc = hsuper.ghc // { withPackages = hsuper.ghc.withHoogle; };
            ghcWithPackages = hself.ghc.withPackages;

            amazonka = hself.callCabal2Nix "amazonka" "${inputs.amazonka}/lib/amazonka";
            amazonka-core = hself.callCabal2Nix "amazonka-core" "${inputs.amazonka}/lib/amazonka-core";
          });
      });
in
{

  languages.haskell = {
    enable = true;
    package = myHaskellPackages.ghc;
    languageServer = null;
  };

}
