{
  inputs,
  home-manager,
  mkHomeManagerModule,
  mkHost,
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
}
