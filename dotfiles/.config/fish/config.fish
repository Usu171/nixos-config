set fish_greeting
set -g fish_key_bindings fish_default_key_bindings

function fish_cursor_preexec --on-event fish_preexec
  printf '\e[5 q'
end

set -gx fish_color_command green

zoxide init fish | source

tv init fish | source
bind \ev tv_smart_autocomplete

set -gx CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense'
carapace _carapace | source


set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --exclude .git'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --exclude .git'
set -gx FZF_ALT_C_OPTS "
  --walker-skip .git,node_modules,target
  --height=40% --min-height=15 --preview-window=right:50%:wrap
  --preview 'eza -a --icons --group-directories-first --tree --level=2 --color=always {}'"
set -gx FZF_CTRL_T_OPTS "
  --walker-skip .git,node_modules,target
  --height=40% --min-height=15 --preview-window=right:50%:wrap
  --preview 'bat --style=numbers --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
fzf --fish | source

atuin init fish | source

set -gx EDITOR nvim
set -gx WORDCHARS '*?_-[]~=&;!$%^(){}<>'
set -gx MANPAGER 'bat -l man --paging=always'

alias ls 'eza --icons --group-directories-first'
alias ll 'ls -lhgM --git'
alias lla 'll -a'
alias la 'ls -la --git'
alias tree 'ls --tree'
alias rls 'command ls'

alias cat 'bat --style=plain --paging=never'
alias rcat 'command cat'

alias frg 'rg -F'
alias c clear

alias objdump 'objdump --visualize-jumps=extended-color --disassembler-color=extended'
alias jp2a 'jp2a --background=dark --color-depth=24 --term-width --term-height'

function clash-proxy
  set -l host 127.0.0.1
  set -l port 7897
  set -l socks_port 7897
  set -l enable_all_proxy 0

  if test (count $argv) -gt 0; and test "$argv[1]" = off
    set -e http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
    set -e all_proxy ALL_PROXY
    echo 'proxy disabled'
    return 0
  end

  if test (count $argv) -gt 0; and string match -rq '^[0-9]+$' -- "$argv[1]"
    set port "$argv[1]"
    set -e argv[1]
  end

  while test (count $argv) -gt 0
    switch "$argv[1]"
      case -p --proxy
        if test (count $argv) -lt 2
          break
        end

        set -l proxy "$argv[2]"
        if string match -q '*:*' -- "$proxy"
          set host (string split -m 1 ':' -- "$proxy")[1]
          set port (string split -m 1 ':' -- "$proxy")[2]
        else
          set host "$proxy"
        end

        set -e argv[1..2]
      case -a --all
        set enable_all_proxy 1
        set -e argv[1]
      case -s --socks-port
        if test (count $argv) -lt 2
          break
        end

        set socks_port "$argv[2]"
        set -e argv[1..2]
      case '*'
        set -e argv[1]
    end
  end

  set -l http_proxy_url "http://$host:$port"
  set -l socks_proxy_url "socks5h://$host:$socks_port"

  set -gx http_proxy "$http_proxy_url"
  set -gx https_proxy "$http_proxy_url"
  set -gx HTTP_PROXY "$http_proxy_url"
  set -gx HTTPS_PROXY "$http_proxy_url"

  if test "$enable_all_proxy" -eq 1
    set -gx all_proxy "$socks_proxy_url"
    set -gx ALL_PROXY "$socks_proxy_url"
  end

  echo "http proxy:  $http_proxy_url"

  if test "$enable_all_proxy" -eq 1
    echo "all proxy:   $socks_proxy_url"
  end
end

function y
  set -l tmp (mktemp -t yazi-cwd.XXXXXX)
  command yazi $argv --cwd-file="$tmp"

  if test -f "$tmp"
    set -l cwd (string trim -- (command cat "$tmp"))
    if test -n "$cwd"; and test "$cwd" != "$PWD"; and test -d "$cwd"
      cd -- "$cwd"
    end
    rm -f -- "$tmp"
  end
end
