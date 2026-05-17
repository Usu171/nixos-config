{
  homeDirectory,
  pkgs,
  ...
}:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      source ${../../dotfiles/.config/fish/config.fish}
    '';
    loginShellInit = ''
      if test "$XDG_CURRENT_DESKTOP" != KDE
        set -gx QT_QPA_PLATFORMTHEME qt6ct
        set -gx QT_QPA_PLATFORMTHEME_QT6 qt6ct
      end

      set -gx PNPM_HOME "${homeDirectory}/.local/share/pnpm"
      if not contains -- "$PNPM_HOME" $PATH
        set -gx PATH "$PNPM_HOME" $PATH
      end
    '';
    plugins = [
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      # {
      #   name = "fifc";
      #   src = pkgs.fishPlugins.fifc.src;
      # }
    ];
  };
}
