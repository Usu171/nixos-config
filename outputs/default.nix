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
  defaultUsername = "usu171";
  defaultHomeDirectory = "/home/${defaultUsername}";
  flakeRoot = ../.;
  inherit (nixpkgs) lib;

  commonOverlays = [
    inputs.nix-alien.overlays.default
  ];

  eachSystem = f: lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
  treefmtEval = eachSystem (pkgs: inputs.treefmt-nix.lib.evalModule pkgs ../treefmt.nix);

  mkPkgs =
    system:
    import nixpkgs {
      inherit system;
      overlays = commonOverlays;
    };
  editorPkgs = mkPkgs system;

  mkHost =
    modules:
    {
      username ? defaultUsername,
      homeDirectory ? defaultHomeDirectory,
    }:
    lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit
          inputs
          username
          homeDirectory
          flakeRoot
          ;
      };
      modules = [
        { system.configurationRevision = self.rev or self.dirtyRev or null; }
        { nixpkgs.overlays = commonOverlays; }
      ]
      ++ modules;
    };

  mkHomeManagerModule =
    homePath:
    {
      username ? defaultUsername,
      homeDirectory ? defaultHomeDirectory,
    }:
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "hm-backup";
      home-manager.extraSpecialArgs = {
        inherit
          inputs
          username
          homeDirectory
          flakeRoot
          ;
      };
      home-manager.users.${username} = import homePath;
    };

  mkHomeConfiguration =
    homePath:
    {
      username ? defaultUsername,
      homeDirectory ? defaultHomeDirectory,
    }:
    home-manager.lib.homeManagerConfiguration {
      pkgs = mkPkgs system;
      extraSpecialArgs = {
        inherit
          inputs
          username
          homeDirectory
          flakeRoot
          ;
      };
      modules = [ homePath ];
    };

  commonArgs = {
    inherit
      inputs
      lib
      mkHomeManagerModule
      mkHost
      ;
    username = defaultUsername;
    homeDirectory = defaultHomeDirectory;
  };

  nixosConfigurations = import ./hosts.nix (commonArgs // { inherit home-manager; });
  homeConfigurations = {
    usu171 = mkHomeConfiguration ../home/profiles/unix.nix { };
    root = mkHomeConfiguration ../home/profiles/installer.nix {
      username = "root";
      homeDirectory = "/root";
    };
  };
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
  inherit
    checks
    deploy
    editorPkgs
    homeConfigurations
    nixosConfigurations
    ;

  devShells = eachSystem (pkgs: {
    default = pkgs.mkShell {
      packages = [
        deploy-rs.packages.${pkgs.stdenv.hostPlatform.system}.deploy-rs
      ];
    };
  });
}
