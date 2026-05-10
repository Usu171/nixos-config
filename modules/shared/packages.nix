{ pkgs, inputs, ... }:

{
  nixpkgs.overlays = [ inputs.nix-alien.overlays.default ];

  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    gcc
    gnumake

    # utils
    zip
    unzip

    nodejs_24
    pnpm

    # editor
    vim
    neovim
    vscode

    # cli
    zsh
    fd
    sd
    jq
    ripgrep
    nushell
    starship
    atuin
    zoxide
    carapace
    fzf
    skim
    eza
    bat
    lnav
    difftastic
    tealdeer
    zellij
    tmux
    yazi
    bottom
    fastfetch
    lazygit
    procs
    mtr


    playerctl
    ddcutil
    dnsutils

    # nix
    nixfmt
    nil
    nixd
    nix-sweep
    nix-tree
    nix-alien
    nix-diff
    dix
    nix-melt
    omnix
  ];

  programs.direnv.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  services.flatpak.enable = true;

}
