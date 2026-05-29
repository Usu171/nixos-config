{ lib, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        ForwardAgent = false;
        AddKeysToAgent = "yes";
        Compression = false;
        ServerAliveInterval = 30;
        ServerAliveCountMax = 3;
        HashKnownHosts = false;
        UserKnownHostsFile = "~/.ssh/known_hosts";
        ControlMaster = "auto";
        ControlPersist = "10m";
        ControlPath = "~/.ssh/master-%r@%n:%p";
      };

      OS = {
        HostName = "192.168.1.3";
        User = "usu171";
      };

      Nix = {
        HostName = "192.168.1.5";
        User = "usu171";
      };

      "github.com" = {
        HostName = "ssh.github.com";
        Port = 443;
      };
    };
  };

  # ssh config 权限问题 https://github.com/nix-community/home-manager/issues/322#issuecomment-3730266609
  home.file = {
    # home-manager wrongly thinks it doesn't manage (and thus shouldn't clobber) this file due to the activation script
    ".ssh/config".force = true;
  };

  home.activation = {
    # https://github.com/nix-community/home-manager/issues/322
    fixSshPermissions = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
      run install -d -m 0700 "$HOME/.ssh"
      if [ -L "$HOME/.ssh/config" ]; then
        src="$(readlink -f "$HOME/.ssh/config")"
        run rm -f "$HOME/.ssh/config"
        run install -m 0600 "$src" "$HOME/.ssh/config"
      fi
    '';
  };
}
