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
    inputs.dms.nixosModules.greeter
    home-manager.nixosModules.home-manager
    (mkHomeManagerModule ../home/profiles/unix.nix)
  ];

  nixos = mkHost [
    ../hosts/nixos
    home-manager.nixosModules.home-manager
    (mkHomeManagerModule ../home/profiles/nixos.nix)
  ];
}
