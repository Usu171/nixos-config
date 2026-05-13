{ pkgs, inputs, ... }:

{
  nixpkgs.overlays = [ inputs.nix-alien.overlays.default ];

  environment.systemPackages = with pkgs; [
    # base
    git
    git-lfs
    wget
    curl
    gcc
    gnumake
    file

    # archives
    zip
    unzipNLS
    xz
    zstd
    _7zip-zstd

    # editor
    vim
    neovim
    helix
  ];

  environment.enableAllTerminfo = true;

  programs.direnv.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
