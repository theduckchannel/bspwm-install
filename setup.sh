#!/bin/bash

source cecho.sh

sudo pacman -Syyu
# ENABLE AUR
clear
cecho -c 'green' "::: Stage 1 - enable AUR"
cecho -c 'white' "Press any key to continue..."
read -p ""

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

cecho -c 'yellow' "aur enabled with success!"

# Install packages fundamentals

clear
cecho -c 'green' "::: Stage 2 - Install fundamentals packages..."
cecho -c 'white' "Press any key to continue..."
read -p ""

 

PACMAN_PACKAGES="alacritty rofi feh scrot picom bspwm sxhkd thunar raw-thumbnailer thunar-archive-plugin midori geany ranger leafpad mpd pipewire pipewire-alsa pipewire-pulse pipewire-jack libfm lxappearance firefox polkit-gnome xfce4-power-manager xorg-fonts-misc papirus-icon-theme exa dunst file-roller parted ttf-fira-code fish wget noto-fonts adapta-gtk-theme neofetch"

sudo pacman -S --noconfirm $PACMAN_PACKAGES

## declare an array variable
declare -a array=("nerd-fonts-iosevka" "nerd-fonts-meslo" "siji-git" "ttf-unifont" "ttf-material-icons-git" "polybar" "i3lock-color")

# get length of an array
arraylength=${#array[@]}

# use for loop to read all values and indexes
for (( i=0; i<${arraylength}; i++ ));
do
  yay -S --noconfirm  ${array[$i]}
done


clear
echo "Packages installed..."

# Install packages fundamentals

clear
cecho -c 'green' "::: Stage 3 - Install dotfiles..."
cecho -c 'white' "Press any key to continue..."
read -p ""


#mkdir ~/.config
cp -r dunst ~/.config
cp -r bspwm/ ~/.config/
cp -r libfm/ ~/.config/
cp -r sxhkd/ ~/.config/
cp -r fish ~/.config/
cp .fehbg ~/
cp -r .Xresources.d/ ~/
cp .Xresources ~/
cp /etc/lxdm/lxdm.conf .
cp -r gtk-3.0 ~/.config




sed -i "s/# autologin=dgod/autologin=$(whoami)/" lxdm.conf 
sed -i "s/# numlock=0/numlock=1/" lxdm.conf 
sed -i "s/# session=\/usr\/bin\/startlxde/session=\/usr\/bin\/bspwm/" lxdm.conf 

sudo cp lxdm.conf /etc/lxdm/lxdm.conf

clear


cecho -c 'yellow' "hummmmmmm, everything ok!!!"
cecho -c 'red' "Press any key to reboot...."
read -p " "
reboot


