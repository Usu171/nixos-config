{ username, ... }:

{
  imports = [
    ../../modules/profiles/wsl.nix
  ];

  networking.hostName = "wsl";

  wsl.enable = true;
  wsl.defaultUser = username;
  wsl.tarball.configPath = ./.;

  system.stateVersion = "25.11";
}
