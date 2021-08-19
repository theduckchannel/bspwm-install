#!/bin/bash
IFACE=`ip link | awk -F: '$0 !~ "lo|vir|wl|^[^0-9]"{print $2;getline}'`
IFACE="${IFACE//[[:space:]]/}"
echo "Internet interface::: $IFACE"
sed -i "s/interface = wlan0/interface = $IFACE/" ~/.config/bspwm/polybar/config





