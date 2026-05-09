{ pkgs, ... }:

{
  programs.firefox.enable = true;
  programs.coolercontrol.enable = true;
  programs.clash-verge = {
    enable = true;
    autoStart = true;
    tunMode = true;
    serviceMode = true;
  };

  systemd.services.clash-verge.serviceConfig = {
    # clash-verge's upstream NixOS module omits CAP_NET_BIND_SERVICE, so DNS
    # cannot bind :53. Clear stale tun devices before startup to avoid the
    # recurring "device or resource busy" failure on reload.
    CapabilityBoundingSet = [
      "CAP_NET_BIND_SERVICE"
      "CAP_NET_ADMIN"
      "CAP_NET_RAW"
      "CAP_SYS_ADMIN"
      "CAP_DAC_OVERRIDE"
      "CAP_SETUID"
      "CAP_SETGID"
      "CAP_CHOWN"
      "CAP_MKNOD"
    ];
    ExecStartPre = [
      "-${pkgs.iproute2}/bin/ip link delete dev Mihomo"
    ];
  };

  networking.firewall = {
    allowedTCPPorts = [ 24800 ];
    allowedUDPPorts = [ 24800 ];
  };

  environment.systemPackages = with pkgs; [
    deskflow
    xwayland-satellite
    wl-clipboard
  ];

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
