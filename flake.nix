{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-darwin" ];
    in
    {
      devShells = forAllSystems (system: 
        let 
          pkgs = import nixpkgs { inherit system; };
        in
          {
            default = pkgs.mkShell ({
              buildInputs = with pkgs; [ zig ];
            });
          }
      );
    };
}
