{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # shell
    nushell

    findutils
    fd
    sd
    ripgrep
    sad
    eza
    bat
    hyperfine
    just
    lnav
    difftastic
    tealdeer
    # json...
    jq
    yq-go
    jc

    # git
    gitoxide
    lazygit
    serie
    gitui

    starship
    atuin
    zoxide
    carapace
    fzf
    skim
    television

    zellij
    tmux

    yazi
    broot
    bottom
    btop
    fastfetch
    procs

    # disk
    gdu
    duf
    dust
    ncdu
    smartmontools

    # systemd
    isd
    systemctl-tui
  ];
}
