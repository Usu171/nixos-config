{ username, homeDirectory, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.settings.trusted-users = [
    "root"
    username
  ];

  nix.settings = {
    # download-buffer-size = 1048576000;
    substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  programs.nh = {
    enable = true;
    # clean.enable = true;
    # clean.extraArgs = "--keep-since 10d --keep 10";
    flake = "${homeDirectory}/nixos-config";
  };
}
