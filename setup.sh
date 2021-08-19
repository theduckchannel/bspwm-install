#!/bin/bash


sudo pacman -Syyu
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
 

PACMAN_PACKAGES="alacritty rofi feh scrot picom bspwm sxhkd pcmanfm midori geany i3lock ranger leafpad mpd pipewire pipewire-alsa pipewire-pulse pipewire-jack libfm lxappearance firefox polkit-gnome xfce4-power-manager xorg-fonts-misc papirus-icon-theme exa dunst file-roller parted ttf-fira-code fish wget"

sudo pacman -S --noconfirm $PACMAN_PACKAGES


yay -S --noconfirm nerd-fonts-iosevka 
yay -S --noconfirm nerd-fonts-meslo 
yay -S --noconfirm siji-git 
yay -S --noconfirm ttf-unifont 
yay -S --noconfirm ttf-material-icons-git 
yay -S --noconfirm fastfetch
yay -S --noconfirm polybar 


clear
echo "Packages installed..."

# Install packages fundamentals

echo "::: Stage 3 - Install dotfiles..."
read -p "Press any key to continue..."

mkdir ~/.config
cp -r bspwm/ ~/.config/
cp -r libfm/ ~/.config/
cp -r pcmanfm/ ~/.config/
cp -r sxhkd/ ~/.config/
cp -r fish ~/.config/
cp .fehbg ~/
cp -r .Xresources.d/ ~/
cp .Xresources ~/
cp /etc/lxdm/lxdm.conf .
sed -i "s/# autologin=dgod/autologin=$(whoami)/" lxdm.conf 
sed -i "s/# numlock=0/numlock=1/" lxdm.conf 
sed -i "s/# session=\/usr\/bin\/startlxde/session=\/usr\/bin\/bspwm/" lxdm.conf 

sudo cp lxdm.conf /etc/lxdm/lxdm.conf

clear

echo ""
echo "hummmmmmm, everything ok!!!"
echo "Press any key to reboot...."


