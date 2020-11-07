{

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.09";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      hs = pkgs.haskellPackages;
      chess = hs.callCabal2nix "chess" ./. {};
    in {
      defaultPackage = chess;
      packages = { inherit chess; };
      devShell = chess.env.overrideAttrs (super: {
        nativeBuildInputs = super.nativeBuildInputs ++ [
          hs.cabal-install
          pkgs.zlib
        ];
      });
    }
  );
}
