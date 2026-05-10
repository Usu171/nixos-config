{
  ...
}:

{
  imports = [
    ../shared
    ../fhs.nix
    ../input.nix
    ../nvidia.nix
    ../podman.nix
    ../portal.nix
    ../services/slurm.nix
    ../services/tailscale.nix
    ../desktop/niri.nix
  ];
}
