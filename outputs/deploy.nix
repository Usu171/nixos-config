{
  deploy-rs,
  nixosConfigurations,
  system,
  username,
  ...
}:
{
  nodes = {
    unix = {
      hostname = "OS";
      sshUser = username;
      user = "root";
      interactiveSudo = true;
      remoteBuild = true;
      profiles.system.path = deploy-rs.lib.${system}.activate.nixos nixosConfigurations.unix;
    };

    nixos = {
      hostname = "Nix";
      sshUser = username;
      user = "root";
      interactiveSudo = true;
      remoteBuild = true;
      profiles.system.path = deploy-rs.lib.${system}.activate.nixos nixosConfigurations.nixos;
    };
  };
}
