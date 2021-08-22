#!/usr/bin/python
import os
import sys
import configparser
import time
import subprocess as sp
# Python 3, function
# Author: J.Hadida (jhadida87 at ggooglemail)

#allow_no_value=False

cp = configparser.ConfigParser(allow_no_value=True)
cp.read('packages.ini')
lxdmCp = configparser.ConfigParser()
username = sp.getoutput('whoami')


def cprint( fmt, fg=None, bg=None, style=None ):
    """
    Colour-printer.

        cprint( 'Hello!' )                                  # normal
        cprint( 'Hello!', fg='g' )                          # green
        cprint( 'Hello!', fg='r', bg='w', style='bx' )      # bold red blinking on white

    List of colours (for fg and bg):
        k   black
        r   red
        g   green
        y   yellow
        b   blue
        m   magenta
        c   cyan
        w   white

    List of styles:
        b   bold
        i   italic
        u   underline
        s   strikethrough
        x   blinking
        r   reverse
        y   fast blinking
        f   faint
        h   hide
    """

    COLCODE = {
        'k': 0, # black
        'r': 1, # red
        'g': 2, # green
        'y': 3, # yellow
        'b': 4, # blue
        'm': 5, # magenta
        'c': 6, # cyan
        'w': 7  # white
    }

    FMTCODE = {
        'b': 1, # bold
        'f': 2, # faint
        'i': 3, # italic
        'u': 4, # underline
        'x': 5, # blinking
        'y': 6, # fast blinking
        'r': 7, # reverse
        'h': 8, # hide
        's': 9, # strikethrough
    }

    # properties
    props = []
    if isinstance(style,str):
        props = [ FMTCODE[s] for s in style ]
    if isinstance(fg,str):
        props.append( 30 + COLCODE[fg] )
    if isinstance(bg,str):
        props.append( 40 + COLCODE[bg] )

    # display
    props = ';'.join([ str(x) for x in props ])
    if props:
        print( '\x1b[%sm%s\x1b[0m' % (props, fmt) )
    else:
        print( fmt )



def cmd(parameter):
    os.system(parameter)
    

def pause():
    time.sleep(3)


def saveLxdmConf():
    with open('lxdm.conf', 'w') as configfile:
        lxdmCp.write(configfile)



def showWelcomeScreen():
    cprint('===========================================================', fg='y', style='b')
    cprint(':: The Duck Channel´s bspwm Style ::', fg='g', style='b')
    cprint('https://github.com/theduckchannel/bspwm-install', fg='c', style='b')
    cprint('===========================================================', fg='y', style='b')
    pause()

 

def installXorg():
    cprint('\r\n\r\n:: Installing xorg...', fg='y', style='b')    
    os.system('sudo pacman --noconfirm -S xorg')
    pause()


def installLxdm(): 
    cprint('\r\n\r\n:: Installing Lxdm...', fg='y', style='b') 
    # install and enable lxdm   
    os.system('sudo pacman --noconfirm -S lxdm')
    os.system('sudo systemctl enable lxdm')
    # Copy lxdm.conf to local copy
    os.system('cp /etc/lxdm/lxdm.conf .')
    lxdmCp.read('lxdm.conf')
    # Modify config
    lxdmCp['base']['autologin'] = username
    lxdmCp['base']['numlock'] = '1'
    lxdmCp['base']['session'] = sp.getoutput('which bspwm')
    # write
    saveLxdmConf()
    os.system('sudo cp lxdm.conf /etc/lxdm/lxdm.conf')
    os.system('rm lxdm.conf')
    pause()
    

def installRegularPackages():
    cprint('\r\n:: Installing Regular packages...', fg='y', style='b')
    regPkgs = ''
    for pkg in cp['Regular']:
        regPkgs = regPkgs + pkg + ' '

    print(regPkgs)
    os.system(f'sudo pacman --noconfirm -S {regPkgs}')
    pause()

def installYayAurHelper():
    cprint('\r\n:: Install Yay AUR Helper...', fg='y', style='b')
    os.system('git clone https://aur.archlinux.org/yay.git') 
    os.chdir('yay')
    os.system('makepkg -si')
    os.chdir('../')
    os.system('rm -rf yay')
    pause()

def installAurPkgs():
    cprint('\r\n:: Installing AUR packages...', fg='y', style='b')
    for pkg in cp['AUR']:
        os.system(f'yay --noconfirm -S {pkg}')

    pause()


def installDotFiles():
    # if ~/.config not exists, so create
    cprint('\r\n:: Installing dotfiles...', fg='y', style='b')
    if(not os.path.isdir(f'/home/{username}/.config')):
        os.mkdir(f'/home/{username}/.config')
    
    os.system(f'cp -rf {os.getcwd()}/dotfiles/.* /home/{username}/.config')
    pause()


def main():
    #showWelcomeScreen()
    #installXorg()
    #installLxdm()
    #installRegularPackages()
    #installYayAurHelper()
    #installAurPkgs()
    installDotFiles()
    




if __name__ == "__main__":
    main()
