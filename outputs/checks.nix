{
  self,
  deploy,
  deploy-rs,
  lib,
  treefmtEval,
  eachSystem,
  ...
}:
lib.recursiveUpdate (eachSystem (pkgs: {
  formatting = treefmtEval.${pkgs.stdenv.hostPlatform.system}.config.build.check self;
})) (builtins.mapAttrs (_: deployLib: deployLib.deployChecks deploy) deploy-rs.lib)
