#!/bin/bash

clear
# ENABLE AUR
echo "::: Stage 1 - enable AUR"
read -p "Press any key to continue..."

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

clear
echo "aur enabled with success!"

# Install packages fundamentals

echo "::: Stage 2 - Install fundamentals packages..."
read -p "Press any key to continue..."
 

PACMAN_PACKAGES="alacritty rofi feh scrot picom bspwm sxhkd pcmanfm midori geany i3lock ranger leafpad mpd pipewire pipewire-alsa pipewire-pulse pipewire-jack libfm lxappearance firefox polkit-gnome xfce4-power-manager"

sudo pacman -S $PACMAN_PACKAGES





YAY_PACKAGES="ttf-iosevka-custom-git polybar betterlockscreen-git nerd-fonts-iosevka" 
yay -S $YAY_PACKAGES
clear
echo "Packages installed..."

# Install packages fundamentals

echo "::: Stage 3 - Install dotfiles..."
read -p "Press any key to continue..."


cp -r bspwm/ ~/.config/
cp -r libfm/ ~/.config/
cp -r pcmanfm/ ~/.config/
cp -r sxhkd/ ~/.config/
cp .fehbg ~/
cp -r .Xresources.d/ ~/
cp .Xresources ~/
sed -i "s/# autologin=dgod/autologin=$(whoami)/" lxdm.conf 
sed -i "s/# numlock=0/numlock=1/" lxdm.conf 
sed -i "s/# session=\/usr\/bin\/startlxde/session=\/usr\/bin\/bspwm/" lxdm.conf 

sudo cp lxdm.conf /etc/lxdm/lxdm.conf

clear
echo "It's ok! Now you can reboot...."

