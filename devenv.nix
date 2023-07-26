{ pkgs, ... }:

{

  languages.haskell = {
    enable = true;
    package = pkgs.haskell.packages.ghc96.ghc;
    languageServer = null;
  };

}
