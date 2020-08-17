source /usr/share/zsh/share/antigen.zsh
antigen init /home/cui/.dotfiles/.antigenrc

export EDITOR=nvim
export ANTIGEN_COMPDUMPFILE=/home/cui/.zcompdumps
export http_proxy="http://127.0.0.1:12333"
export https_proxy="http://127.0.0.1:12333"

# 禁止自动转义粘贴的内容
DISABLE_MAGIC_FUNCTIONS=true
# 使用通配符
setopt no_nomatch

alias cp='cp -ri'
alias dbon='sudo systemctl start mariadb.service'
alias dbf='sudo systemctl stop mariadb.service'

alias fcd='cd $(find * -type d | fzf)'
alias fvim='nvim $(fzf)'

alias ga='git add'
alias gaa='git add --all'
alias gap='git add -p'

alias gb='git branch'
alias gba='git branch -a -vv'
alias gbd='git branch -d'
alias gbD='git branch -D'

alias gc='git commit -v'
alias gca='git commit -av'
alias gcaa='git commit -av --amend'
alias gcb='git checkout -b'
alias gcd='git checkout dev'
alias gcm='git checkout master'
alias gco='git checkout'

alias gd='git difftool -d'

alias gl='git pull'
alias gla="(git pull) && (git branch | grep -v \"\* \" | xargs -I @ sh -c 'git checkout @ ; git pull')"
alias gls='git ls-files'
alias glo="git log --graph --pretty='%Cred%h%Creset - %Cblue%cn%Creset %C(auto)%d%Creset%s %Cgreen(%ad)%Creset' --date=short"
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

alias makej='make -j'
alias more='less'
alias mson='sudo systemctl start mssql-server.service'
alias msoff='sudo systemctl stop mssql-server.service'

alias pins='sudo pacman -S'
alias pse='pacman -Ss'
alias puni='sudo pacman -Rsn'
alias py='python'

alias rb='reboot'
alias rename='perl-rename'
alias rf='rm -rf'

alias sab='sudo systemctl enable'
alias sds='sudo systemctl disable'
alias sta='systemctl status'
alias stt='sudo systemctl start'
alias stp='sudo systemctl stop'

alias tomon='sudo /usr/share/tomcat8/bin/startup.sh'
alias tomoff='sudo /usr/share/tomcat8/bin/shutdown.sh'
alias ty='typora'

alias vim='nvim'
alias vz='nvim ~/.zshrc'

bindkey ',' autosuggest-accept

function mc { command mkdir $1 && cd $1 }
function __ {
    cd / \
        && mount LABEL="Linux_backup" \
        && sudo sh -c "date > rs_time" \
        && sudo rsync -ashHP --delete --exclude-from=/shit.list /* /mnt \
        && umount /mnt \
        && rsync -ashHP -zz --delete /boot/* myserver:/root/boot_backup \
        && cd
    }

vman () {
    export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
        vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
        -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
        -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

    # invoke man page
    man $*
    # we muse unset the PAGER, so regular man pager is used afterwards
    unset PAGER
}

