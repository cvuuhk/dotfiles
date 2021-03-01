source /usr/share/zsh/share/antigen.zsh
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen theme nicoulaj
antigen apply

export EDITOR=nvim
export ANTIGEN_COMPDUMPFILE=/home/cui/.zcompdumps
export http_proxy="http://127.0.0.1:7890"
export https_proxy=$http_proxy

# 禁止自动转义粘贴的内容
DISABLE_MAGIC_FUNCTIONS=true
# 使用通配符
setopt no_nomatch

alias -g cp='cp -ri'

alias dbf='sudo systemctl stop mariadb.service'
alias dbon='sudo systemctl start mariadb.service'

alias ffmpeg="ffmpeg -hide_banner"
alias ffprobe='ffprobe -hide_banner'

alias ga='git add'
alias gaa='git add --all'
alias gap='git add -p'
alias gb='git branch'
alias gbD='git branch -D'
alias gba='git branch -a -vv'
alias gbd='git branch -d'
alias gc='git commit -v'
alias gca='git commit -av'
alias gcaa='git commit -av --amend'
alias gcb='git checkout -b'
alias gcd='git checkout dev'
alias gcm='git checkout main'
alias gco='git checkout'
alias gd='git diff'
alias gdd='git difftool -d'
alias gdt='git difftool'
alias gl='git pull'
alias gla="(git pull) && (git branch | grep -v \"\* \" | xargs -I @ sh -c 'git checkout @ ; git pull')"
alias glo="git log --graph --pretty='%Cred%h%Creset - %Cblue%cn%Creset %C(auto)%d%Creset%s %Cgreen(%ad)%Creset' --date=short"
alias gls='git ls-files'
alias gm='git merge'
alias gmt='git mergetool'
alias gp='git push'
alias gpa='git push --all'
alias gpd='git push origin --delete'
alias gpf='git push -f'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gr='git remote -v'
alias gra='git remote add'
alias grep='grep -iE --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias grm='git rm'
alias grmc='git rm --cached'
alias grs='git reset'
alias grsh='git reset --hard'
alias gss='git status -s'
alias gst='git stash'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gt='git tag'
alias gta='git tag -a'
alias gtd='git tag -d'

alias l='ls -lh'
alias la='ls -A'
alias lla='ls -lAh'
alias ls='ls --color=tty'

alias pins='yay -S'
alias pse='yay -Ss'
alias puni='yay -Rsn'
alias py='python'

alias rename='perl-rename'
alias -g rf='rm -rf'

alias sds='sudo systemctl disable'
alias sea='sudo systemctl enable'
alias sta='systemctl status'
alias stp='sudo systemctl stop'
alias stt='sudo systemctl start'

alias ta='tmux attach -t'
alias tn='tmux new -s'

alias vim='nvim'
alias vv='nvim ~/.dotfiles/vimrc'
alias vz='nvim ~/.zshrc'

alias yd='youtube-dl --external-downloader aria2c --external-downloader-args "-x 16 -k 1M"'

bindkey ',' autosuggest-accept

function __ {
    cd / \
        && mount LABEL="Linux_backup" \
        && sudo sh -c "date > last_backup_datetime" \
        && sudo sh -c "rsync -aHAXvP --delete --exclude={\
\"dev/*\",\"proc/*\",\"sys/*\",\"tmp/*\",\"run/*\",\"mnt/*\",\"media/*\",\"lost+found\",\
\"var/lib/dhcpcd/*\",\"home/*/.gvfs\",\
\"home/*/.cache\",\
\"home/*/.cargo\",\
\"home/*/.config/chromium\",\
\"home/*/.local/share/Steam/*\",\
\"home/*/.local/share/TelegramDesktop/*\",\
\"home/*/.local/share/Trash/*\",\
\"home/*/.local/share/virtualbox/*\",\
\"home/*/.m2\",\
\"home/*/documents/data/*\",\
\"var/cache/pacman/pkg/*\"\
} / /mnt" \
        && umount /mnt \
        && cd
    }
