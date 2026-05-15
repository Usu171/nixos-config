{ modulesPath, ... }:

{
  imports = [
    ../../modules/services/clash.nix
  ];

  image.modules.myinstaller = "${modulesPath}/installer/cd-dvd/installation-cd-graphical-calamares-plasma6.nix";

  networking.hostName = "installer";

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [ "root" ];
  };

  # nix flake check Placeholders for evaluation (overridden by nixos-rebuild build-image variant)
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
  };
  boot.loader.grub.enable = false;
}
