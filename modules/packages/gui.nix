{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vscode
    google-chrome
  ];

  programs.firefox.enable = true;

  services.flatpak.enable = true;
}
