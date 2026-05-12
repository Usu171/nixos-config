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

    # xorg.libX11
    # xorg.libXcomposite
    # xorg.libXdamage
    # xorg.libXext
    # xorg.libXfixes
    # xorg.libXrandr

    fontconfig
    freetype
    libglvnd
    dbus
    libX11
    libxt
    libxau
    libxcb
    libxext
    libxft
    xcbutil
    xcbutilimage
    xcbutilkeysyms
    xcbutilrenderutil
    xcbutilwm
    libxkbcommon
    libXdmcp
    libXrender
    libxscrnsaver
    libSM
    libICE
    libGL
    libGLU
    mesa

    libxcrypt-legacy
    motif

  ];
}
