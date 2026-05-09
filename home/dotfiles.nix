{
  pkgs,
  ...
}:

{
  home.file.".config" = {
    source = ../dotfiles/.config;
    recursive = true;
  };

  home.file.".local/share" = {
    source = ../dotfiles/.local/share;
    recursive = true;
  };

  xdg.dataFile."fcitx5/themes/Matugen/radio.png".source =
    "${pkgs.fcitx5}/share/fcitx5/themes/default/radio.png";
  xdg.dataFile."fcitx5/themes/Matugen/arrow.png".source =
    "${pkgs.fcitx5}/share/fcitx5/themes/default/arrow.png";
}
