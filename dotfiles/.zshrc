autoload -Uz compinit # 补全系统
compinit

precmd() { echo -ne '\e[5 q' } # 在每次提示符前设置光标为竖线

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

zinit ice depth=1
zinit light romkatv/powerlevel10k # 主题

zinit light Aloxaf/fzf-tab # fzf-tab 补全

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

unalias zi # 取消zinit的zi alias，避免与zoxide冲突
eval "$(zoxide init zsh)" # 目录跳转 z/zi

# ---补全---
eval "$(tv init zsh)"
bindkey '^[v' tv-smart-autocomplete

export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # carapace 补全桥接
zstyle ':completion:*' format '%d' # 显示补全来源
source <(carapace _carapace) # carapace 补全 会和fzf-tab冲突？ echo $_comps[ls] -> _carapace_completer

# zstyle ':completion:*' menu no # 关闭默认的补全菜单
# 用 fd
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --exclude .git' # --follow
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git' # --follow
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --height=40% --min-height=15 --preview-window=right:55%:wrap
  --preview 'eza -a  --icons --group-directories-first --tree --level=2 --color=always {}'"
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --height=40% --min-height=15 --preview-window=right:55%:wrap
  --preview 'bat --style=numbers --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
source <(fzf --zsh)

# 修
# 白名单 carapace
# compdef _carapace_completer docker
# 黑名单 carapace
# compdef _eza eza
# compdef _bat bat

# 修复？ https://github.com/carapace-sh/carapace/issues/1177
# 会导致z和cd之外的路径$realpath为空 preview出问题
zstyle ':fzf-tab:*' query-string ''

# debug
# echo $_comps[xx]
# zstyle ':fzf-tab:complete:*' fzf-preview 'echo "word: [$word], realpath: [$realpath]"'
# 只预览z/cd
# zstyle ':fzf-tab:complete:(z|cd):*' fzf-preview 'eza -1 --color=always $realpath'
# $realpath 预览 与上面冲突
# zstyle ':fzf-tab:complete:*' fzf-preview '
# if [[ -d "$realpath" ]]; then
#   eza -1a --color=always "$realpath"
# else
#   bat --style=numbers --color=always "$realpath"
# fi
# '

zstyle ':fzf-tab:*' fzf-flags \
  --height=40% \
  --min-height=15 \
  --preview-window=right:55%:wrap

zstyle ':fzf-tab:complete:(z|cd):*' fzf-preview '
eza -a  --icons --group-directories-first --tree --level=2 --color=always $realpath
'

zstyle ':fzf-tab:complete:(export|unset):*' fzf-preview '
echo ${(P)word}
'

# zstyle ':fzf-tab:complete:ssh:*' fzf-preview '
# dig $word
# '

# 其余用$word预览
zstyle ':fzf-tab:complete:*' fzf-preview '
word="${word%%[[:space:]]}"
# word="${word%/}"
word="${word/#\~/$HOME}"
echo "[$word]"

if [[ -n "$word" && -e "$word" ]]; then
  if [[ -d "$word" ]]; then
    eza -1a --icons --color=always "$word"
  elif [[ -f "$word" ]]; then
    bat --style=numbers --color=always "$word"
  fi
else
  # echo "$word"
fi
'

# ---补全---

unsetopt bang_hist # 禁用历史扩展 !

# . "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)" # 历史

setopt no_nomatch
export EDITOR=nvim
export WORDCHARS='*?_-[]~=&;!$%^(){}<>'

# alias
alias ls='eza --icons --group-directories-first'
alias ll='ls -lhgM --git'
alias lla='ll -a'
alias la='ls -la --git'
alias tree='ls --tree'
alias rls='command ls'

alias cat='bat --style=plain --paging=never'
export MANPAGER="bat -l man --paging=always" # 用bat显示man页面
alias rcat='command cat'

alias frg='rg -F'

alias c='clear'

alias objdump='objdump --visualize-jumps=extended-color --disassembler-color=extended'
alias jp2a='jp2a --background=dark --color-depth=24 --term-width --term-height'


# functions
function clash-proxy() {
    local host="127.0.0.1"
    # HTTP proxy 默认端口
    local port="7897"
    # SOCKS proxy 默认端口
    local socks_port="7897"

    local enable_all_proxy=0

    if [[ "$1" == "off" ]]; then
        unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
        unset all_proxy ALL_PROXY
        echo "proxy disabled"
        return 0
    fi

    # 第一个纯数字参数作为 http port
    if [[ "$1" =~ '^[0-9]+$' ]]; then
        port="$1"
        shift
    fi

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -p|--proxy)
                shift

                if [[ "$1" == *:* ]]; then
                    host="${1%%:*}"
                    port="${1##*:}"
                else
                    host="$1"
                fi
                ;;

            -a|--all)
                enable_all_proxy=1
                ;;

            -s|--socks-port)
                shift
                socks_port="$1"
                ;;
        esac

        shift
    done

    local http_proxy_url="http://${host}:${port}"
    local socks_proxy_url="socks5h://${host}:${socks_port}"

    export http_proxy="$http_proxy_url"
    export https_proxy="$http_proxy_url"
    export HTTP_PROXY="$http_proxy_url"
    export HTTPS_PROXY="$http_proxy_url"

    if (( enable_all_proxy )); then
        export all_proxy="$socks_proxy_url"
        export ALL_PROXY="$socks_proxy_url"
    fi

    echo "http proxy:  $http_proxy_url"

    if (( enable_all_proxy )); then
        echo "all proxy:   $socks_proxy_url"
    fi
}

# yazi https://yazi-rs.github.io/docs/quick-start#shell-wrapper
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}
