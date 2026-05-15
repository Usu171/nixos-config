{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vscode
    google-chrome
  ];

  programs.firefox.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  services.flatpak.enable = true;
}
