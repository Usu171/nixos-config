{ pkgs, ... }:

{

  services.zerotierone = {
    enable = true;
    joinNetworks = [ "632ea29085c5c3c1" ];
  };

  networking.firewall.allowedUDPPorts = [ 9993 ];

  environment.systemPackages = with pkgs; [ zerotierone ];
}
