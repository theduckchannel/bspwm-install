#!/usr/bin/python
import os
import sys
import configparser
# Python 3, function
# Author: J.Hadida (jhadida87 at ggooglemail)

#allow_no_value=False

cp = configparser.ConfigParser(allow_no_value=True)
cp.read('packages.ini')


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
    

def showWelcomeScreen():
    cprint('===========================================================', fg='y', style='b')
    cprint(':: The Duck Channel´s bspwm Style ::', fg='g', style='b')
    cprint('https://github.com/theduckchannel/bspwm-install', fg='c', style='b')
    cprint('===========================================================', fg='y', style='b')

    
def installRegularPackages():
    cprint('\r\n:: Installing Regular packages...', fg='y', style='b')
    regPkgs = ''
    for pkg in cp['Regular']:
        #print(pkg)
        regPkgs = regPkgs + pkg + ' '

    print(regPkgs)

def main():
    showWelcomeScreen()
    #print(cp.sections())
    installRegularPackages()
    #for section in cp.sections():
    #    print(section)
    #    for name in cp.items(section):
    #        print(name[0])



if __name__ == "__main__":
    main()
