{ pkgs, ... }:

{
  networking.networkmanager.enable = false;
  networking.firewall.enable = false;

  services.printing.enable = false;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      X11Forwarding = true;
    };
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
