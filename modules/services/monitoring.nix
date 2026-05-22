_:

{
  services.prometheus.exporters.node = {
    enable = true;
    openFirewall = true;
    port = 9100;
    enabledCollectors = [
      "processes"
      "systemd"
    ];
  };

  services.prometheus = {
    enable = true;
    port = 9095;
    globalConfig.scrape_interval = "15s";
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [
          {
            targets = [ "127.0.0.1:9100" ];
          }
        ];
      }
    ];
  };

  services.grafana = {
    enable = true;
    settings = {
      security.secret_key = "1145141919810";
      server = {
        http_addr = "0.0.0.0";
        http_port = 3005;
      };
    };

    provision = {
      enable = true;

      datasources.settings = {
        apiVersion = 1;
        datasources = [
          {
            name = "Prometheus";
            type = "prometheus";
            access = "proxy";
            url = "http://127.0.0.1:9095";
            isDefault = true;
          }
        ];
      };
    };
  };
}
