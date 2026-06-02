{ flakeRoot, ... }:

{
  home.file.".config/nvim" = {
    source = flakeRoot + /dotfiles/.config/nvim;
    recursive = true;
  };

  home.file.".config/zellij/config.kdl".source = flakeRoot + /dotfiles/.config/zellij/config.kdl;

  xdg.configFile."tmux-plugins/tmux-which-key/config.yaml".source =
    flakeRoot + /dotfiles/.config/tmux-plugins/tmux-which-key/config.yaml;
}
