{
  homeDirectory,
  lib,
  pkgs,
  ...
}:

let
  ohMyZsh = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
in

{
  home.file.".p10k.zsh".source = ../../dotfiles/.p10k.zsh;
  home.packages = [
    pkgs.git-open
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = false; # 该选项默认为true /etc/zshrc 也默认会开 必须确保只开一次，否则会有性能问题
    autosuggestion.enable = true;
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting;
        file = "share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh";
      }
      {
        name = "history-substring-search";
        src = pkgs.zsh-history-substring-search;
        file = "share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh";
      }
      {
        name = "zsh-autopair";
        src = pkgs.zsh-autopair;
        file = "share/zsh/zsh-autopair/autopair.zsh";
      }
    ];
    initContent = lib.mkMerge [
      (lib.mkOrder 10 ''
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '')

      (lib.mkOrder 550 ''
        fpath+=(${pkgs.zsh-completions}/share/zsh/site-functions)

        # $ENABLE_CORRECTION == "true" # correction 开关

        source ${ohMyZsh}/lib/async_prompt.zsh # 异步执行
        # source ${ohMyZsh}/lib/bzr.zsh # Bazaar 已经似了
        # source ${ohMyZsh}/lib/cli.zsh # omz 命令行工具 管理 omz 的
        source ${ohMyZsh}/lib/clipboard.zsh # clipcopy clippaste 系统剪贴板复制粘贴
        # source ${ohMyZsh}/lib/compfix.zsh # 检测和处理不安全的补全目录
        # source ${ohMyZsh}/lib/completion.zsh # 补全
        # source ${ohMyZsh}/lib/correction.zsh # 纠错 cp man mkdir mv sudo su

        # source ${ohMyZsh}/lib/diagnostics.zsh # omz诊断工具 omz_diagnostic_dump
        source ${ohMyZsh}/lib/directories.zsh # 目录 ... n='cd -n'
        source ${ohMyZsh}/lib/functions.zsh # 一些实用函数 open take* mkcd
        # source ${ohMyZsh}/lib/git.zsh # git信息获取显示
        # source ${ohMyZsh}/lib/grep.zsh # rg：？
        source ${ohMyZsh}/lib/history.zsh # 历史记录配置 时间戳 等
        source ${ohMyZsh}/lib/key-bindings.zsh # 快捷键设置 emacs key bindings bindkey -e
        source ${ohMyZsh}/lib/misc.zsh # 杂项 小工具 依赖functions
        # source ${ohMyZsh}/lib/nvm.zsh # nvm
        # source ${ohMyZsh}/lib/prompt_info_functions.zsh # 获取编程语言版本信息
        # source ${ohMyZsh}/lib/spectrum.zsh # 颜色支持库
        source ${ohMyZsh}/lib/termsupport.zsh # 终端窗口标题设置 更新
        # source ${ohMyZsh}/lib/theme-and-appearance.zsh # omz 主题外观库
        # source ${ohMyZsh}/lib/vcs_info.zsh # 补丁修复 CVE-2021-45444 漏洞，确保 vcs_info 输出中的 % 字符被正确转义，防止潜在的命令注入攻击 zsh versions from 5.0.3 to 5.8.

        source ${ohMyZsh}/plugins/git/git.plugin.zsh # git简写命令 https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
        # source ${ohMyZsh}/plugins/pip/pip.plugin.zsh # pip补全,简写命令 https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/pip
        # source ${ohMyZsh}/plugins/command-not-found/command-not-found.plugin.zsh # 插件会在输入不存在的命令时提示安装哪个包，使用programs.command-not-found https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/command-not-found/README.md
        # 应当使用 https://github.com/nix-community/nix-index-database 自带 command-not-found shell集成
        # 而不是programs.command-not-found

      '')

      (lib.mkAfter ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme # 性能比放plugin更好一些
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

        source ${../../dotfiles/.zshrc}

        export PNPM_HOME="${homeDirectory}/.local/share/pnpm"
        case ":$PATH:" in
          *":$PNPM_HOME/bin:"*) ;;
          *) export PATH="$PNPM_HOME/bin:$PATH" ;;
        esac

        export BUN_INSTALL="$HOME/.bun"
        export PATH="$BUN_INSTALL/bin:$PATH"
      '')
    ];
    profileExtra = ''
      if [[ "$XDG_CURRENT_DESKTOP" != "KDE" ]]; then
        export QT_QPA_PLATFORMTHEME=qt6ct
        export QT_QPA_PLATFORMTHEME_QT6=qt6ct
      fi
    '';
  };
}
