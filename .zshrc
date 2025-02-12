if [[ -z "${DISPLAY}" ]] && [[ "${XDG_VTNR}" -eq 1 ]] && [[ "$(whoami)" != "root" ]]; then
  # exec startx
fi

export http_proxy="http://localhost:7890"
export https_proxy=$http_proxy

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

autoload -Uz compinit;
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# Load powerlevel10k theme
zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

zinit ice lucid wait atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma-continuum/fast-syntax-highlighting 
compinit

# bindkey -v # for vi
bindkey -e # for emacs
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
# 使用 Home End 键
bindkey '\e[H'    beginning-of-line
bindkey '\e[F'    end-of-line

export EDITOR=nvim
export MANPAGER='nvim +Man!'

# the detailed meaning of the below three variable can be found in `man zshparam`.
export HISTFILE=~/.histfile
export HISTSIZE=1000000   # the number of items for the internal history list
export SAVEHIST=1000000   # maximum number of items for the history file

# man 色彩高亮
# export LESS_TERMCAP_mb=$'\E[1m\E[32m'
# export LESS_TERMCAP_mh=$'\E[2m'
# export LESS_TERMCAP_mr=$'\E[7m'
# export LESS_TERMCAP_md=$'\E[1m\E[36m'
# export LESS_TERMCAP_ZW=""
# export LESS_TERMCAP_us=$'\E[4m\E[1m\E[37m'
# export LESS_TERMCAP_me=$'\E(B\E[m'
# export LESS_TERMCAP_ue=$'\E[24m\E(B\E[m'
# export LESS_TERMCAP_ZO=""
# export LESS_TERMCAP_ZN=""
# export LESS_TERMCAP_se=$'\E[27m\E(B\E[m'
# export LESS_TERMCAP_ZV=""
# export LESS_TERMCAP_so=$'\E[1m\E[33m\E[44m'

# The meaning of these options can be found in man page of `zshoptions`.
setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt EXTENDED_HISTORY  # record command start time
setopt HIST_IGNORE_SPACE # ignore lines which start with space.

# 使用通配符
setopt NO_NOMATCH
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 控制 CTRL-W 行为
WORDCHARS=${WORDCHARS/\/}

function zshaddhistory() {
  if [[ "$1" =~ "(^ |http|reset|rar|zip)" ]] ; then
      return 1
  else
      return 0
  fi
}

alias ..='cd ..'
alias cp='cp -ri'
alias aa='sudo chattr +a .'
alias ra='sudo chattr -a .'

alias au='aunpack'

alias cb='cargo build'
alias cr='cargo run'
alias ct='cargo test'
alias clbf='sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"'

alias em='emerge'

alias ffmpeg="ffmpeg -hide_banner"
alias ffprobe='ffprobe -hide_banner'

alias gcl='git clone'
alias gss='git status -s'

alias ll='ls -lh'
alias la='ls -A'
alias lla='ls -lAh'
alias ls='ls --color=tty'
alias lg='lazygit'

alias ra='. ranger'
alias reboot='sudo reboot'
alias rf='rm -rf'

alias sudo='sudo '

alias ta='tmux attach -t'
alias tn='tmux new -s'
alias todo='vi ~/.todo'

alias vv='nvim -O ~/.config/nvim/lua/base.lua ~/.config/nvim/lua/plugin.lua -c "cd /home/cui/.config/nvim/lua"'
alias vz='nvim ~/.zshrc'

alias ssh="TERM=xterm-256color $(which ssh)"

function ccat {
    dos2unix $1
    iconv -f GBK -t UTF8 $1 -o $1
    cat $1
}

function tmp {
    prefix=$(date +"%Y%m%d_%H%M%S")
    temp_dir=$(mktemp -d /tmp/$prefix.XXXXXX)

    cd "$temp_dir"
}
