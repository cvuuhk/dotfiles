#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run picom -b
run parcellite
run fcitx5
run gentoo-pipewire-launcher restart
# run numlockx
