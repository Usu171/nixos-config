inputs@{
  self,
  nixpkgs,
  home-manager,
  systems,
  deploy-rs,
  ...
}:
let
  system = "x86_64-linux";
  username = "usu171";
  homeDirectory = "/home/${username}";
  inherit (nixpkgs) lib;

  eachSystem = f: lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
  treefmtEval = eachSystem (pkgs: inputs.treefmt-nix.lib.evalModule pkgs ../treefmt.nix);

  mkHomeManagerModule = homePath: {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.backupFileExtension = "hm-backup";
    home-manager.extraSpecialArgs = {
      inherit inputs username homeDirectory;
    };
    home-manager.users.${username} = import homePath;
  };

  mkHost =
    modules:
    lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs username homeDirectory;
      };
      modules = [
        { system.configurationRevision = self.rev or self.dirtyRev or null; }
      ]
      ++ modules;
    };

  commonArgs = {
    inherit
      inputs
      username
      homeDirectory
      lib
      mkHomeManagerModule
      mkHost
      ;
  };

  nixosConfigurations = import ./hosts.nix (commonArgs // { inherit home-manager; });
  deploy = import ./deploy.nix (commonArgs // { inherit self deploy-rs nixosConfigurations; });
  checks = import ./checks.nix {
    inherit
      deploy
      self
      deploy-rs
      lib
      treefmtEval
      eachSystem
      ;
  };
in
{
  formatter = eachSystem (pkgs: treefmtEval.${pkgs.stdenv.hostPlatform.system}.config.build.wrapper);
  inherit checks deploy nixosConfigurations;

  devShells = eachSystem (pkgs: {
    default = pkgs.mkShell {
      packages = [
        deploy-rs.packages.${pkgs.stdenv.hostPlatform.system}.deploy-rs
      ];
    };
  });
}
