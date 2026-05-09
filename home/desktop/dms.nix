{ inputs, pkgs, ... }:

{
  imports = [
    # ./home/desktop/noctalia.nix
    inputs.dms.homeModules.dank-material-shell
    inputs.dms-plugin-registry.modules.default
    inputs.danksearch.homeModules.dsearch
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
    dgop.package = inputs.dgop.packages.${pkgs.stdenv.hostPlatform.system}.default;
    plugins = {
      calculator.enable = true;
      dankKDEConnect.enable = true;
    };
  };

  programs.dsearch.enable = true;
}
