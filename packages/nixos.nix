{ pkgs, ... }:

let
  myPython = pkgs.python3.withPackages (
    ps: with ps; [
      numpy
    ]
  );
in
{
  programs.firefox.enable = true;
  programs.clash-verge = {
    enable = true;
    autoStart = true;
  };

  environment.systemPackages = with pkgs; [
    myPython
    google-chrome
    kdePackages.kate
  ];
}
