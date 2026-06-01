{ pkgs, inputs, ... }:

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
    nix-output-monitor
    nix-search-cli

    nix-prefetch-github
    nix-init
    inputs.nixpkgs-hammering.packages.${pkgs.system}.nixpkgs-hammering
    nixpkgs-review

    nix-eval-jobs
    nix-fast-build

    devenv
  ];
}
