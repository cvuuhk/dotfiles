if [[ -z "${DISPLAY}" ]] && [[ "${XDG_VTNR}" -eq 1 ]] && [[ "$(whoami)" != "root" ]]; then
  exec startx
fi

export http_proxy="http://127.0.0.1:7890"
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

autoload -U compinit; compinit
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit's installer chunk
zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit light zdharma-continuum/fast-syntax-highlighting 
zinit ice lucid wait='0' atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

export EDITOR=nvim
bindkey -e # for emacs
# bindkey -v # for vi
# the detailed meaning of the below three variable can be found in `man zshparam`.
export HISTFILE=~/.histfile
export HISTSIZE=1000000   # the number of items for the internal history list
export SAVEHIST=1000000   # maximum number of items for the history file

# man 色彩高亮
export LESS_TERMCAP_mb=$'\E[1m\E[32m'
export LESS_TERMCAP_mh=$'\E[2m'
export LESS_TERMCAP_mr=$'\E[7m'
export LESS_TERMCAP_md=$'\E[1m\E[36m'
export LESS_TERMCAP_ZW=""
export LESS_TERMCAP_us=$'\E[4m\E[1m\E[37m'
export LESS_TERMCAP_me=$'\E(B\E[m'
export LESS_TERMCAP_ue=$'\E[24m\E(B\E[m'
export LESS_TERMCAP_ZO=""
export LESS_TERMCAP_ZN=""
export LESS_TERMCAP_se=$'\E[27m\E(B\E[m'
export LESS_TERMCAP_ZV=""
export LESS_TERMCAP_so=$'\E[1m\E[33m\E[44m'

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

# 使用 Home End 键
bindkey '\e[H'    beginning-of-line
bindkey '\e[F'    end-of-line

alias ..='cd ..'
alias cp='cp -ri'
alias aa='sudo chattr +a .'
alias ra='sudo chattr -a .'

alias au='aunpack'

alias cb='cargo build'
alias cr='cargo run'
alias ct='cargo test'
alias clbf='sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"'

alias ffmpeg="ffmpeg -hide_banner"
alias ffprobe='ffprobe -hide_banner'

alias gcl='git clone'
alias gss='git status -s'

alias ll='ls -lh'
alias la='ls -A'
alias lla='ls -lAh'
alias ls='ls --color=tty'
alias lg='lazygit'

alias mountsmb='sudo mount -t cifs -o uid=cui,gid=cui,file_mode=0644,dir_mode=0755'
alias mountusb='sudo mount -t ntfs3 /dev/sdb1 /mnt'

alias ossutil='/home/cui/.local/bin/ossutil64'

alias pacman='sudo pacman'
alias py='python'

alias ra='. ranger'
alias rename='perl-rename'
alias -g rf='rm -rf'

alias sys='sudo systemctl'
alias sudo='sudo '

alias ta='tmux attach -t'
alias tn='tmux new -s'
alias todo='vi ~/.todo'

alias vi='nvim'
alias vv='nvim ~/.config/nvim/lua/plugin/config.lua -c "cd /home/cui/.config/nvim/lua"'
alias vz='nvim ~/.zshrc'

alias yd='youtube-dl'
alias yde='youtube-dl --external-downloader aria2c --external-downloader-args "-x 8 -k 1M"'
alias yg='you-get --no-caption'

function ccat {
    dos2unix $1
    iconv -f GBK -t UTF8 $1 -o $1
    cat $1
}
