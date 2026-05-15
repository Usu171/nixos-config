{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nixfmt
    nil
    nixd
    nix-sweep
    nix-tree
    nix-alien
    nix-diff
    dix
    nix-melt
    omnix

    devenv
  ];
}
