{
  config,
  username,
  homeDirectory,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;

  nix.settings.trusted-users = [
    "root"
    username # "@wheel"
  ];

  nix.settings = {
    # download-buffer-size = 1048576000;
    substituters = [
      "ssh-ng://${username}@OS"
      "ssh-ng://${username}@Nix"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://nix-community.cachix.org"
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nix.sshServe = {
    enable = true;
    protocol = "ssh-ng";
    trusted = true;
    write = true;
    inherit (config.users.users.${username}.openssh.authorizedKeys) keys;
  };

  programs.nh = {
    enable = true;
    # clean.enable = true;
    # clean.extraArgs = "--keep-since 10d --keep 10";
    flake = "${homeDirectory}/nixos-config";
  };
}
