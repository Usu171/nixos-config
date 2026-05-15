{
  ...
}:

{
  imports = [
    ../shared
    ../fhs.nix
    ../podman.nix
    ../desktop/cage.nix
    ../containers/beszel.nix
    ../containers/sub-store.nix
    ../containers/homepage.nix
    ../services/clash.nix
    ../services/cockpit.nix
    ../services/cliproxy.nix
    # ../services/zerotier.nix
    ../services/tailscale.nix
    ../packages/shared
    ../packages/dev.nix
  ];
}
