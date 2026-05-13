{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cage
    foot
  ];
}
