{
  ...
}:

{
  imports = [
    ../../modules/profiles/unix.nix
    ../../packages/unix.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "unix";

  boot.kernelModules = [
    "nct6775"
    "i2c-dev"
    "uninput"
    "tun"
  ];

  hardware.bluetooth.enable = true;

  services.power-profiles-daemon.enable = true;
  services.accounts-daemon.enable = true;
  services.upower.enable = true;

  networking.firewall.enable = false;

  networking.firewall = {
    allowedTCPPorts = [
      22
      9097
    ];
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };

  system.stateVersion = "25.11"; # Did you read the comment?
}
