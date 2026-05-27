{ pkgs, ... }:

let
  terminals = with pkgs; [
    alacritty
    contour
    foot
    ghostty
    kitty
    mtm
    rio
    st
    tmux
    wezterm
  ];
in
{
  environment.systemPackages = map (terminal: terminal.terminfo) terminals;
}
