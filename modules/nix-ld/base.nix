{ pkgs, ... }:

{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    openssl
    curl
    libxml2
    xz
    bzip2
    zstd

    icu
    libuv

    glibc
    glib
    libnghttp2
    brotli
    c-ares
    libssh2
  ];
}
