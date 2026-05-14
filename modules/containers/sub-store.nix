_:

{
  systemd.tmpfiles.rules = [
    "d /var/lib/sub-store-data 0750 root root - -"
  ];

  virtualisation.oci-containers.containers.sub-store = {
    image = "docker.io/xream/sub-store:2.23.0";
    autoStart = true;

    ports = [
      "0.0.0.0:3001:3001"
    ];

    volumes = [
      "/var/lib/sub-store-data:/opt/app/data:Z"
    ];

    environment = {
      SUB_STORE_FRONTEND_HOST = "0.0.0.0";
      SUB_STORE_FRONTEND_PORT = "3001";
      SUB_STORE_FRONTEND_BACKEND_PATH = "/vQ8kR2mN7pL4xT9c";
      SUB_STORE_BACKEND_SYNC_CRON = "55 23 * * *";
      SUB_STORE_BACKEND_DEFAULT_PROXY = "http://host.containers.internal:7897";
    };

    extraOptions = [
      "--replace"
      "--log-opt=max-size=10m"
      "--log-opt=max-file=3"
    ];
  };

  networking.firewall.allowedTCPPorts = [
    3001
  ];
}
