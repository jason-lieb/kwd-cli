{
  inputs = {
    stable.url = "github:nixos/nixpkgs/nixos-23.05";
    haskell.url = "github:nixos/nixpkgs/6dc93f0daec55ee2f441da385aaf143863e3d671";
    freckle.url = "github:freckle/flakes?dir=main";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = inputs: inputs.flake-utils.lib.eachDefaultSystem (system:
    let
      nixpkgsArgs = { inherit system; config = { }; };
      nixpkgs = {
        stable = import inputs.stable nixpkgsArgs;
        haskell = import inputs.haskell nixpkgsArgs;
      };
      freckle = inputs.freckle.packages.${system};
    in
    rec {
      packages = {
        cabal = nixpkgs.stable.cabal-install;

        fourmolu = freckle.fourmolu-0-13-x;

        ghc = freckle.ghc-9-2-7;

        haskell-language-server =
          nixpkgs.stable.haskell-language-server.override
            { supportedGhcVersions = [ "927" ]; };

        hlint =
          nixpkgs.stable.haskell.lib.justStaticExecutables
            nixpkgs.stable.hlint;

        stack = nixpkgs.stable.writeShellApplication {
          name = "stack";
          text = ''
            ${nixpkgs.stable.stack}/bin/stack --system-ghc --no-nix "$@"
          '';
        }
        ;
      };

      devShells.default = nixpkgs.stable.mkShell {
        buildInputs = with (nixpkgs.stable); [
          pcre
          pcre.dev
          zlib
          zlib.dev
        ];

        nativeBuildInputs = with (packages); [
          cabal
          fourmolu
          ghc
          haskell-language-server
          hlint
          stack
        ];

        LOCALE_ARCHIVE = "${nixpkgs.stable.glibcLocales}/lib/locale/locale-archive";

        shellHook = ''
          export STACK_YAML=stack.yaml
        '';
      };
    });
}