{
  homeDirectory,
  lib,
  modulesPath,
  pkgs,
  ...
}:

let
  mihomoSeedDirString = "${toString ./.}/mihomo";
  mihomoSeedDir =
    if builtins.pathExists mihomoSeedDirString then
      builtins.path {
        path = mihomoSeedDirString;
        name = "iso-mihomo-seed";
      }
    else
      null;
  mihomoConfigTargetDir = "${homeDirectory}/.local/share/mihomo";
  mihomoStateTargetDir = "/var/lib/private/mihomo";
in

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

  # If hosts/iso/mihomo exists, bake its contents into the ISO and seed the
  # live system with Mihomo runtime state under /var/lib/private/mihomo. Keep
  # config.yaml mirrored to the configured configFile path as well.
  system.activationScripts.mihomoSeed = lib.mkIf (mihomoSeedDir != null) ''
    install -d -m 0700 "${mihomoStateTargetDir}"
    ${pkgs.coreutils}/bin/cp -rf ${mihomoSeedDir}/. "${mihomoStateTargetDir}/"
    ${pkgs.coreutils}/bin/chmod -R u+rwX,go-rwx "${mihomoStateTargetDir}"

    if [ -f "${mihomoSeedDir}/config.yaml" ]; then
      install -d -m 0700 "${mihomoConfigTargetDir}"
      ${pkgs.coreutils}/bin/cp -f "${mihomoSeedDir}/config.yaml" "${mihomoConfigTargetDir}/config.yaml"
      ${pkgs.coreutils}/bin/chmod 0600 "${mihomoConfigTargetDir}/config.yaml"
    fi
  '';

  systemd.services.mihomo-fetch-config.enable = lib.mkIf (mihomoSeedDir != null) false;
  systemd.timers.mihomo-fetch-config.enable = lib.mkIf (mihomoSeedDir != null) false;

  # nix flake check Placeholders for evaluation (overridden by nixos-rebuild build-image variant)
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
  };
  boot.loader.grub.enable = false;
}
