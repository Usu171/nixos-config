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
    gitoxide
    # json...
    jq
    yq-go
    jc

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
    bottom
    btop
    fastfetch
    lazygit
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
