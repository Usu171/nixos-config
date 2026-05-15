{ pkgs, ... }:

{
  programs.firefox.enable = true;
  programs.coolercontrol.enable = true;
  environment.systemPackages = with pkgs; [
    deskflow
    xwayland-satellite
    wl-clipboard
    opencode
  ];

  networking.firewall = {
    allowedTCPPorts = [ 24800 ];
    allowedUDPPorts = [ 24800 ];
  };
}
