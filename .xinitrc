#!/bin/sh

eval "$(dbus-launch --sh-syntax --exit-with-session)"

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
export LANG=zh_CN.UTF-8
export LC_MESSAGES=en_US.UTF-8

export _JAVA_AWT_WM_NONREPARENTING=1
export XMODIFIERS="@im=fcitx"
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx
export QT_QPA_PLATFORMTHEME=qt6ct

# kitty support IME
export SDL_IM_MODULE=fcitx
export INPUT_METHOD=fcitx
export GLFW_IM_MODULE=ibus

xset r rate 180 50 # 键盘重复速度
xset s off -dpms # disable screensaver
# xinput --disable $(xinput list --id-only "SynPS/2 Synaptics TouchPad")
unclutter --timeout 1 --jitter 4 --ignore-scrolling & # 隐藏鼠标指针
# screenkey --start-disabled &

run() {
  # 使用 basename 提取命令名，-x 精确匹配进程名
  cmd=$(basename "$1")
  if ! pgrep -x "$cmd" >/dev/null; then
    "$@" &
  fi
}

run picom -b
run parcellite
run fcitx5
run gentoo-pipewire-launcher restart
run flameshot

# feh --bg-scale ~/.wallpaper.png
# dwm

awesome
