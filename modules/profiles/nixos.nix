{
  ...
}:

{
  imports = [
    ../shared
    ../fhs.nix
    ../podman.nix
    ../containers/sub-store.nix
    ../services/clash.nix
    ../services/cliproxy.nix
    # ../services/zerotier.nix
    ../services/tailscale.nix
    ../desktop/plasma.nix
  ];
}
