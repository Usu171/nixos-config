{ inputs, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    sensibleOnTop = true; # 在最上方加sensible

    # nix自己的默认值会被写进conf，需要自定义值覆盖
    terminal = "tmux-256color";
    baseIndex = 1;
    keyMode = "vi";
    prefix = "C-g";
    mouse = true;
    focusEvents = true;
    escapeTime = 0;
    historyLimit = 50000;

    tmuxp.enable = true;

    plugins = with pkgs.tmuxPlugins; [
      pain-control
      vim-tmux-navigator
      inputs.tmux-powerkit.packages.${pkgs.stdenv.hostPlatform.system}.default
      resurrect
      continuum
      open
    ];

    extraConfig = ''
    set -g status-keys emacs # 覆盖 keyMode 设置

    bind-key -T copy-mode-vi v send -X begin-selection
    bind-key -T copy-mode-vi y send -X copy-selection-and-cancel
    bind-key S setw synchronize-panes # 同步窗格输入
    set -s set-clipboard on # 允许与系统剪贴板交互
    set -g allow-passthrough on # 允许控制序列

    setw -g monitor-activity on # 窗口有活动时提示

    set -as terminal-features ',xterm-*:RGB'


    # PowerKit Bar
    set -g @powerkit_plugins "git,ssh,cpu,memory,battery,datetime" # hostname
    set -g @powerkit_theme "catppuccin"
    set -g @powerkit_theme_variant "mocha"
    # set -g @powerkit_transparent "true"
    set -g @powerkit_plugin_datetime_format "%m-%d %H:%M:%S"
    set -g @powerkit_status_interval "5"

    set -g popup-style 'bg=default'

    # Save
    set -g @continuum-restore 'on' # 自动恢复功能
    set -g @continuum-save-interval '15' # 默认15分钟
    set -g @resurrect-capture-pane-contents 'on' # 捕获面板内容以便恢复时显示
    # set -g @resurrect-strategy-nvim 'session' # 使用nvim session恢复
    '';
  };

  programs.sesh = {
    enable = true;
    tmuxKey = "T";
  };

  programs.fzf = {
    enable = true;
    tmux.enableShellIntegration = true;
  };
}
