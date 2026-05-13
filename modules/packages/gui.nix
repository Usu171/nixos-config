{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vscode
    google-chrome
  ];

  programs.firefox.enable = true;
}
