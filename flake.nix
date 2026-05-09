{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # nixos-xx.xx
    home-manager = {
      url = "github:nix-community/home-manager/master"; # release-xx.xx
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/default";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    deploy-rs.url = "github:serokell/deploy-rs";
    # noctalia = {
    #   url = "github:noctalia-dev/noctalia-shell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    danksearch = {
      url = "github:AvengeMedia/danksearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
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

      # treefmt
      eachSystem = f: lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
      treefmtEval = eachSystem (pkgs: inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix);

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
          inherit modules;
        };
    in
    {
      # treefmt
      formatter = eachSystem (pkgs: treefmtEval.${pkgs.stdenv.hostPlatform.system}.config.build.wrapper);
      checks = lib.recursiveUpdate (eachSystem (pkgs: {
        formatting = treefmtEval.${pkgs.stdenv.hostPlatform.system}.config.build.check self;
      })) (builtins.mapAttrs (_: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib);

      devShells = eachSystem (pkgs: {
        default = pkgs.mkShell {
          packages = [
            deploy-rs.packages.${pkgs.stdenv.hostPlatform.system}.deploy-rs
          ];
        };
      });

      nixosConfigurations.unix = mkHost [
        ./hosts/unix
        inputs.dms.nixosModules.greeter
        home-manager.nixosModules.home-manager
        (mkHomeManagerModule ./home/profiles/unix.nix)
      ];

      nixosConfigurations.nixos = mkHost [
        ./hosts/nixos
        home-manager.nixosModules.home-manager
        (mkHomeManagerModule ./home/profiles/nixos.nix)
      ];

      deploy.nodes = {
        unix = {
          hostname = "OS";
          sshUser = username;
          user = "root";
          interactiveSudo = true;
          remoteBuild = true;
          profiles.system.path = deploy-rs.lib.${system}.activate.nixos self.nixosConfigurations.unix;
        };

        nixos = {
          hostname = "Nix";
          sshUser = username;
          user = "root";
          interactiveSudo = true;
          remoteBuild = true;
          profiles.system.path = deploy-rs.lib.${system}.activate.nixos self.nixosConfigurations.nixos;
        };
      };
    };
}
