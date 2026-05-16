{ username, ... }:

{
  imports = [
    ../../modules/profiles/wsl.nix
  ];

  networking.hostName = "wsl";

  wsl = {
    enable = true;
    defaultUser = username;
    tarball.configPath = ../../.;
    wslConf = {
      interop = {
        enabled = true;
        appendWindowsPath = false;
      };
    };
  };

  system.stateVersion = "25.11";
}
