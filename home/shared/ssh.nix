_:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "yes";
        compression = false;
        serverAliveInterval = 30;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "auto";
        controlPersist = "10m";
        controlPath = "~/.ssh/master-%r@%n:%p";
      };

      OS = {
        hostname = "192.168.1.3";
        user = "usu171";
      };

      Nix = {
        hostname = "192.168.1.5";
        user = "usu171";
      };
    };
  };
}
