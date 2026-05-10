{ pkgs, ... }:

{
  boot.kernelModules = [ "tun" ];

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
}
