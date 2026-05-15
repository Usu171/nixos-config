{
  deploy-rs,
  nixosConfigurations,
  ...
}:
{
  nodes = {
    unix = {
      hostname = "OS";
      sshUser = "root";
      user = "root";
      interactiveSudo = false;
      remoteBuild = true;
      profiles.system.path = deploy-rs.lib.x86_64-linux.activate.nixos nixosConfigurations.unix;
    };

    nixos = {
      hostname = "Nix";
      sshUser = "root";
      user = "root";
      interactiveSudo = false;
      remoteBuild = true;
      profiles.system.path = deploy-rs.lib.x86_64-linux.activate.nixos nixosConfigurations.nixos;
    };
  };
}
