_:

{
  systemd.services.cliproxy = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      User = "usu171";
      Environment = [
        "http_proxy=http://127.0.0.1:7897"
        "https_proxy=http://127.0.0.1:7897"
        "HTTP_PROXY=http://127.0.0.1:7897"
        "HTTPS_PROXY=http://127.0.0.1:7897"
      ];
      ExecStart = "/home/usu171/cliproxy/cli-proxy-api -config /home/usu171/cliproxy/config.yaml";
      WorkingDirectory = "/home/usu171/cliproxy";
      Restart = "always";
      RestartSec = 3;
    };
  };
}
