{
  pkgs,
  homeDirectory,
  ...
}:

{
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
    KERNEL=="uinput", GROUP="input", MODE="0660"
  '';

  systemd.services.xremap = {
    description = "xremap";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-udev-settle.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.xremap}/bin/xremap --watch --mouse ${homeDirectory}/.config/xremap/config.yml";
      Restart = "always";
      RestartSec = 2;
    };
  };
}
