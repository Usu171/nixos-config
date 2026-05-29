{
  flakeRoot,
  lib,
  username,
  homeDirectory,
  ...
}:

{
  imports = [
    ../shared
  ];

  home.username = lib.mkForce username;
  home.homeDirectory = lib.mkForce homeDirectory;

  home.file.".config/nvim" = {
    source = flakeRoot + /dotfiles/.config/nvim;
    recursive = true;
  };

  home.file.".config/zellij/config.kdl".source = flakeRoot + /dotfiles/.config/zellij/config.kdl;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";
}
