{
  inputs,
  home-manager,
  mkHomeManagerModule,
  mkHost,
  lib,
  ...
}:
{
  unix = mkHost [
    ../hosts/unix
    inputs.vscode-server.nixosModules.default
    { services.vscode-server.enable = true; }
    inputs.dms.nixosModules.greeter
    home-manager.nixosModules.home-manager
    (mkHomeManagerModule ../home/profiles/unix.nix)
  ];

  nixos = mkHost [
    ../hosts/nixos
    inputs.vscode-server.nixosModules.default
    { services.vscode-server.enable = true; }
    home-manager.nixosModules.home-manager
    (mkHomeManagerModule ../home/profiles/nixos.nix)
  ];

  installer = lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs;
      username = "root";
      homeDirectory = "/root";
    };
    modules = [
      ../hosts/iso
    ];
  };
}
