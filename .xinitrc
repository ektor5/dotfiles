#!/bin/bash

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

## Ek5

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

## env
export GTK_THEME=Adwaita:dark
export TERMINAL=termite
export TERMCMD=termite

xset -b
setxkbmap us

## bg
#xsetroot -solid "#222222"
feh --bg-scale ~/.bg_image

## cursor
xsetroot -cursor_name left_ptr

## lock
xautolock -time 10 -locker "i3lock -i .bg_image" &

## ssh 
eval $(ssh-agent)

## exec 
exec i3
#exec xmonad
#exec spectrwm
#exec ck-launch-session xmonad

#exec gnome-session
#exec startkde
#exec startxfce4

#exec twm
#exec xterm
