_:

{
  systemd.tmpfiles.rules = [
    "d /var/lib/beszel-data 0750 root root - -"
    "d /var/lib/beszel-agent-data 0750 root root - -"
    "d /var/lib/beszel-socket 0755 root root - -"
    "d /var/lib/beszel-secrets 0700 root root - -"
  ];

  virtualisation.oci-containers.containers = {
    beszel = {
      image = "docker.io/henrygd/beszel:latest";
      autoStart = true;

      ports = [
        "0.0.0.0:8090:8090"
      ];

      volumes = [
        "/var/lib/beszel-data:/beszel_data:Z"
        "/var/lib/beszel-socket:/beszel_socket:Z"
      ];

      environment = {
        APP_URL = "http://localhost:8090";
      };

      extraOptions = [
        "--replace"
        "--pull=always"
        "--log-opt=max-size=10m"
        "--log-opt=max-file=3"
      ];
    };

    beszel-agent = {
      image = "docker.io/henrygd/beszel-agent:alpine";
      autoStart = true;
      volumes = [
        "/var/lib/beszel-agent-data:/var/lib/beszel-agent:Z"
        "/var/lib/beszel-socket:/beszel_socket:Z"
        "/var/run/docker.sock:/var/run/docker.sock:ro"
      ];

      environment = {
        LISTEN = "/beszel_socket/beszel.sock";
        HUB_URL = "http://localhost:8090";
      };
      environmentFiles = [
        "/var/lib/beszel-secrets/agent.env"
      ];
      extraOptions = [
        "--replace"
        "--pull=always"
        "--network=host"
        "--device=/dev/sda:/dev/sda"
        "--cap-add=SYS_RAWIO"
        "--cap-add=SYS_ADMIN"
        "--log-opt=max-size=10m"
        "--log-opt=max-file=3"
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [
    8090
  ];
}
