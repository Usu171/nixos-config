{
  homeDirectory,
  pkgs,
  username,
  ...
}:

let
  mihomoConfigUrl = "http://192.168.1.5:3001/vQ8kR2mN7pL4xT9c/api/file/master";
  mihomoConfigPath = "${homeDirectory}/.local/share/mihomo/config.yaml";
in
{
  boot.kernelModules = [ "tun" ];

  services.mihomo = {
    enable = true;
    tunMode = true;
    processesInfo = true;
    webui = pkgs.metacubexd;
    configFile = mihomoConfigPath;
  };

  systemd.services.mihomo-fetch-config = {
    description = "Fetch Mihomo config from HTTP endpoint";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = username;
      ExecStart = pkgs.writeShellScript "fetch-mihomo-config" ''
        set -euo pipefail
        umask 077
        install -d -m 0700 "$(dirname ${mihomoConfigPath})"
        ${pkgs.curl}/bin/curl -fsSL "${mihomoConfigUrl}" -o ${mihomoConfigPath}.tmp
        mv ${mihomoConfigPath}.tmp ${mihomoConfigPath}
      '';
      ExecStartPost = [
        "+${pkgs.writeShellScript "cleanup-mihomo-tun" ''
          ${pkgs.iproute2}/bin/ip link delete dev Mihomo || true
        ''}"
        "+${pkgs.systemd}/bin/systemctl restart mihomo.service"
      ];
    };
  };

  systemd.timers.mihomo-fetch-config = {
    description = "Run Mihomo config fetch daily";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 02:55:00";
      Persistent = true;
      Unit = "mihomo-fetch-config.service";
    };
  };

  services.resolved.enable = true;
  networking.networkmanager.dns = "systemd-resolved";
  networking.nameservers = [ "127.0.0.1" ];
}
