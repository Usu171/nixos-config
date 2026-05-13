{ pkgs, ... }:

let
  myPython = pkgs.python3.withPackages (
    ps: with ps; [
      numpy
    ]
  );
in
{
  environment.systemPackages = with pkgs; [
    myPython
    kdePackages.kate
  ];
}
