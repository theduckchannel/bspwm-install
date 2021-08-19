#!/bin/bash



#Keyboard layout br-abnt2
setxkbmap -model abnt2 -layout br -variant abnt2

xrandr -s 1920x1080
~/.fehbg
polybar-msg cmd restart


git config credential.helper store
git config --global user.name "theduckchannel"
git config --global user.email "fredcox@gmail.com"
