{ pkgs, ... }:

{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    openssl
    icu
    libuv
    curl
    libxml2
    xz
    bzip2
    zstd

    glibc
    glib
    libnghttp2
    brotli
    c-ares
    libssh2
  ];
}
