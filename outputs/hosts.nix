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

  wsl = mkHost [
    ../hosts/wsl
    inputs.nixos-wsl.nixosModules.default
    inputs.vscode-server.nixosModules.default
    { services.vscode-server.enable = true; }
    home-manager.nixosModules.home-manager
    (mkHomeManagerModule ../home/profiles/wsl.nix)
  ];

  installer = lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs;
      username = "root";
      homeDirectory = "/root";
    };
    modules = [
      ../hosts/installer
    ];
  };
}
