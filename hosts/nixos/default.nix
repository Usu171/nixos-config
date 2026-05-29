{ flakeRoot, ... }:

{
  imports = [
    (flakeRoot + /modules/profiles/nixos.nix)
    (flakeRoot + /packages/nixos.nix)
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos";

  boot.kernelParams = [ "consoleblank=300" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  networking.firewall.enable = false;

  networking.firewall.allowedTCPPorts = [
    22
    8317
  ];

  system.stateVersion = "25.05"; # Did you read the comment?
}
