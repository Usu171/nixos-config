### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk




# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi



# $ENABLE_CORRECTION == "true" # correction 开关

zinit snippet OMZL::async_prompt.zsh # 异步执行
# zinit snippet OMZL::bzr.zsh # Bazaar 已经似了
# zinit snippet OMZL::cli.zsh # omz 命令行工具 管理 omz 的
zinit snippet OMZL::clipboard.zsh # clipcopy clippaste 系统剪贴板复制粘贴
# zinit snippet OMZL::compfix.zsh # 检测和处理不安全的补全目录
# zinit snippet OMZL::completion.zsh # 补全
# zinit snippet OMZL::correction.zsh # 纠错 cp man mkdir mv sudo su

# zinit snippet OMZL::diagnostics.zsh # omz诊断工具 omz_diagnostic_dump
zinit snippet OMZL::directories.zsh # 目录 ... n='cd -n'
zinit snippet OMZL::functions.zsh # 一些实用函数 open take* mkcd
# zinit snippet OMZL::git.zsh # git信息获取显示
# zinit snippet OMZL::grep.zsh # rg：？
zinit snippet OMZL::history.zsh # 历史记录配置 时间戳 等
zinit snippet OMZL::key-bindings.zsh # 快捷键设置 emacs key bindings bindkey -e
zinit snippet OMZL::misc.zsh # 杂项 小工具 依赖functions
# zinit snippet OMZL::nvm.zsh # nvm
# zinit snippet OMZL::prompt_info_functions.zsh # 获取编程语言版本信息
# zinit snippet OMZL::spectrum.zsh # 颜色支持库
zinit snippet OMZL::termsupport.zsh # 终端窗口标题设置 更新
# zinit snippet OMZL::theme-and-appearance.zsh # omz 主题外观库
# zinit snippet OMZL::vcs_info.zsh # 补丁修复 CVE-2021-45444 漏洞，确保 vcs_info 输出中的 % 字符被正确转义，防止潜在的命令注入攻击 zsh versions from 5.0.3 to 5.8.

zinit snippet OMZP::git # git简写命令 https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
# zinit snippet OMZP::pip # pip补全,简写命令 https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/pip
# zinit snippet OMZP::command-not-found # 插件会在输入不存在的命令时提示安装哪个包，使用programs.command-not-found https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/command-not-found/README.md
# 应当使用 https://github.com/nix-community/nix-index-database 自带 command-not-found shell集成
# 而不是programs.command-not-found



zinit light paulirish/git-open # git open 打开GitHub页面
zinit light zsh-users/zsh-autosuggestions # 灰色提示历史命令
zinit light zsh-users/zsh-completions # 额外命令补全

zinit light zdharma-continuum/fast-syntax-highlighting # 语法高亮
zinit light zsh-users/zsh-history-substring-search # 历史子字符串搜索
zinit light hlissner/zsh-autopair # 自动括号配对

zinit ice depth=1
zinit light romkatv/powerlevel10k # 主题

zinit light Aloxaf/fzf-tab # fzf-tab 补全

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh