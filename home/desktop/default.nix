{
  pkgs,
  ...
}:

{
  imports = [
    ./dms.nix
    # ./noctalia.nix
  ];

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;

    gtk.enable = true;
    x11.enable = true;
  };
}
