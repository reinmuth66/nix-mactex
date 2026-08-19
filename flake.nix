{
  description = "Personal LaTeX toolchain (texliveFull, MacTeX-equivalent) for per-project flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          devShells.default = pkgs.mkShell {
            packages = [ pkgs.texliveFull pkgs.ghostscript ];
          };

          formatter = pkgs.nixpkgs-fmt;
        });
}
