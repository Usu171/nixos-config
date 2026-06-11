{ pkgs, ... }:

{
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
    libarchive
    unar

    # editor
    vim
    neovim
    helix
    fresh-editor
  ];

  # enableAllTerminfo包含的termite已废弃，构建爆炸 !目前nixpkgs已删除termite
  # environment.enableAllTerminfo = true;

  programs.direnv.enable = true;
}
