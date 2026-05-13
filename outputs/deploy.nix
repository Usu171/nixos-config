{
  deploy-rs,
  nixosConfigurations,
  system,
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
      profiles.system.path = deploy-rs.lib.${system}.activate.nixos nixosConfigurations.unix;
    };

    nixos = {
      hostname = "Nix";
      sshUser = "root";
      user = "root";
      interactiveSudo = false;
      remoteBuild = true;
      profiles.system.path = deploy-rs.lib.${system}.activate.nixos nixosConfigurations.nixos;
    };
  };
}
