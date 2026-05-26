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
    tmux-xpanes

    yazi
    broot
    bottom
    btop
    fastfetch
    procs

    # disk
    gdu
    ncdu
    duf
    dust
    smartmontools
    nvme-cli

    # systemd
    isd
    systemctl-tui
  ];
}
