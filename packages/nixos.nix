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
  environment.systemPackages = with pkgs; [
    myPython
    google-chrome
    kdePackages.kate
  ];
}
