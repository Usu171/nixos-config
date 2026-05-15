_:

{
  systemd.services.podman-homepage.serviceConfig.StateDirectory = "homepage";

  virtualisation.oci-containers.containers = {
    homepage = {
      image = "ghcr.io/gethomepage/homepage:latest";
      autoStart = true;

      ports = [
        "0.0.0.0:3002:3000"
      ];

      volumes = [
        "/var/lib/homepage:/app/config:Z"
        "/var/run/docker.sock:/var/run/docker.sock:ro"
      ];

      environment = {
        HOMEPAGE_ALLOWED_HOSTS = "*";
      };

      extraOptions = [
        "--replace"
        "--log-opt=max-size=10m"
        "--log-opt=max-file=3"
      ];
    };

  };

  networking.firewall.allowedTCPPorts = [
    3002
  ];
}
