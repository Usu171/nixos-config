{ pkgs, ... }:

{
  networking.networkmanager.enable = true;

  services.printing.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      X11Forwarding = true;
    };
  };

  programs.mosh.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  services.envfs.enable = true;
}
