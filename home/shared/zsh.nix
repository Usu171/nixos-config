{ homeDirectory, ... }:

{
  home.file.".p10k.zsh".source = ../../dotfiles/.p10k.zsh;
  # home.file.".zshrc".source = ../dotfiles/.zshrc;

  programs.zsh = {
    enable = true;
    initContent = ''
      source ${../../dotfiles/.zshrc}
      export PNPM_HOME="${homeDirectory}/.local/share/pnpm"
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac
    '';
    profileExtra = ''
      if [[ "$XDG_CURRENT_DESKTOP" != "KDE" ]]; then
        export QT_QPA_PLATFORMTHEME=qt6ct
        export QT_QPA_PLATFORMTHEME_QT6=qt6ct
      fi
    '';
  };
}
