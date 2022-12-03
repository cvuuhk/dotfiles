#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

xmodmap "$usermodmap"

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# my own config
function status_bar() {
  while [ true ]; do
    bash ~/.config/dwm-6.4/bar.sh
    sleep 1
  done
}
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORMTHEME=qt5ct
export LLVM_SYMBOLIZER_PATH=/usr/bin/llvm-symbolizer
# see https://unix.stackexchange.com/a/295652/332452
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# see https://wiki.archlinux.org/title/GNOME/Keyring#xinitrc
eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
# picom --experimental-backends --config ~/.config/picom/picom.conf &
picom -b &
light -S 50%
parcellite & # 剪贴板

fcitx5 &
numlockx & # auto enable numlock
xset r rate 180 50 # 键盘重复速度
xset s off -dpms # disable screensaver
xinput --disable $(xinput list --id-only "SynPS/2 Synaptics TouchPad")
unclutter --timeout 1 --jitter 4 --ignore-scrolling & # 隐藏鼠标指针
screenkey --start-disabled &

feh --bg-scale ~/.wallpaper.png
status_bar &

exec dwm

# exec awesome
