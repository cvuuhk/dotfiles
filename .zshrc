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
export HISTSIZE=3000   # the number of items for the internal history list
export SAVEHIST=3000   # maximum number of items for the history file

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
# alias ra='sudo chattr -a .'

alias au='aunpack'

alias cb='cmake -S . -B build && cmake --build build'
alias cbr='cmake -S . -B build && cmake --build build && ./build/bin/main'
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

alias mountntfs="mount -t ntfs3 -o rw,uid=$(id -u),gid=$(id -g),umask=0022"

alias nvcc='/opt/cuda/bin/nvcc'

# alias ra='. ranger'
alias reboot='sudo reboot'
alias rf='rm -rf'

alias sudo='sudo '

alias ta='tmux attach -t'
alias tn='tmux new -s'
alias todo='vi ~/.todo'

alias vr='VIMRUNTIME=runtime ./build/bin/nvim'
alias vv='nvim -O ~/.config/nvim/lua/plugins/config.lua ~/.config/nvim/lua/config/keymaps.lua -c "cd /home/cui/.config/nvim/lua"'
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

function ra() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# NACOS_AUTH_TOKEN: Nacos 用于生成JWT Token的密钥，使用长度大于32字符的字符串，再经过Base64编码。
# NACOS_AUTH_TOKEN=${your_nacos_auth_secret_token}
export your_nacos_auth_secret_token='MTIzNDU2Nzg5MDEyMzQ1Njc4OTAxMjM0NTY3ODkwMTIzNDU2Nzg5MA=='

# NACOS_AUTH_IDENTITY_KEY: Nacos Server端之间 Inner API的身份标识的Key，必填。
# NACOS_AUTH_IDENTITY_KEY=${your_nacos_server_identity_key}
export your_nacos_server_identity_key='nacos_key'

# NACOS_AUTH_IDENTITY_VALUE: Nacos Server端之间 Inner API的身份标识的Value，必填。
# NACOS_AUTH_IDENTITY_VALUE=${your_nacos_server_identity_value}
export your_nacos_server_identity_value='nacos_value'

alias pku_env='docker run -it --rm maxxing/compiler-dev bash'

export CMAKE_GENERATOR=Ninja
