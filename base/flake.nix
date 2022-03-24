{
  description = "Base flake with vscode configuration.";

  inputs = {
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      # System types to support.
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Nixpkgs instantiated for supported system types.
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {
      packages = forAllSystems (system: { inherit (nixpkgsFor.${system}) hello; });

      devShell = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        pkgs.mkShell {
          buildInputs = [ pkgs.nixpkgs-fmt ];
        });
    };
}
