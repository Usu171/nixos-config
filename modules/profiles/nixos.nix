{
  ...
}:

{
  imports = [
    ../shared
    ../clash.nix
    ../fhs.nix
    ../podman.nix
    ../containers/sub-store.nix
    ../services/cliproxy.nix
    # ../services/zerotier.nix
    ../services/tailscale.nix
    ../desktop/plasma.nix
  ];
}
