_:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Usu171";
        email = "usu171@proton.me";
      };
      gpg.format = "ssh";
      feature.manyFiles = true;
    };
    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
    maintenance.enable = true;
  };
}
