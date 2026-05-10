{ pkgs, ... }:

{
  programs.firefox.enable = true;
  programs.coolercontrol.enable = true;
  environment.systemPackages = with pkgs; [
    deskflow
    xwayland-satellite
    wl-clipboard
  ];

  networking.firewall = {
    allowedTCPPorts = [ 24800 ];
    allowedUDPPorts = [ 24800 ];
  };

  # programs.nix-ld.enable = true;
  # programs.nix-ld.libraries = with pkgs; [

  #   stdenv.cc.cc.lib
  #   zlib
  #   openssl
  #   icu
  #   libuv
  #   curl
  #   libxml2
  #   xz
  #   bzip2
  #   zstd

  #   glibc
  #   glib
  #   libnghttp2
  #   brotli
  #   c-ares
  #   libssh2

  #   # xorg.libX11
  #   # xorg.libXcomposite
  #   # xorg.libXdamage
  #   # xorg.libXext
  #   # xorg.libXfixes
  #   # xorg.libXrandr
  #   # libGL
  #   # fontconfig
  #   # freetype

  #   stdenv.cc.cc.lib
  #   zlib
  #   openssl
  #   icu
  #   libuv
  #   curl
  #   libxml2
  #   xz
  #   bzip2
  #   zstd

  #   glibc
  #   glib
  #   libnghttp2
  #   brotli
  #   c-ares
  #   libssh2

  #   fontconfig
  #   freetype
  #   libglvnd
  #   dbus
  #   libX11
  #   libxt
  #   libxau
  #   libxcb
  #   libxext
  #   libxft
  #   xcbutil
  #   xcbutilimage
  #   xcbutilkeysyms
  #   xcbutilrenderutil
  #   xcbutilwm
  #   libxkbcommon
  #   libXdmcp
  #   libXrender
  #   libxscrnsaver
  #   libSM
  #   libICE
  #   libGL
  #   libGLU
  #   mesa

  #   libxcrypt-legacy
  #   motif

  # ];
}
