_:

{
  programs.git = {
    enable = true;
    settings.user = {
      name = "Usu171";
      email = "usu171@proton.me";
    };
    settings.gpg.format = "ssh";
    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
  };
}
