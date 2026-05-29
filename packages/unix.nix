{ pkgs, ... }:

{
  programs.firefox.enable = true;
  programs.coolercontrol.enable = true;
  environment.systemPackages = with pkgs; [
    deskflow
    xwayland-satellite
    wl-clipboard
    mpv
  ];

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
    package = pkgs.obs-studio.override {
      cudaSupport = true;
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 24800 ];
    allowedUDPPorts = [ 24800 ];
  };
}
