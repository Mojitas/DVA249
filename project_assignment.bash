#!/bin/bash

export TERM=${TERM:-dumb}
export TERM=xterm-256color

source proj_funcs.bash # some functions
source proj_menu.bash # Menu functions

###############################Functions#################################

menu_select()
{
    clear
    case $CHOICE in

    ni)
#    func    
    bash temp/networkinfo
    ;;
    ua)
    echo $CHOICE
    ;;
    ul)
    echo $CHOICE
    ;;
    uv)
    echo $CHOICE
    ;;
    um)
    echo $CHOICE
    ;;
    ud)
    echo $CHOICE
    ;;
    ga)
    echo $CHOICE
    ;;
    gl)
    echo $CHOICE
    ;;
    gv)
    echo $CHOICE
    ;;
    gm)
    echo $CHOICE
    ;;
    gd)
    echo $CHOICE
    ;;
    fa)
    echo $CHOICE
    ;;
    fl)
    echo $CHOICE
    ;;
    fv)
    echo $CHOICE
    ;;
    fm)
    echo $CHOICE
    ;;
    fd)
    echo $CHOICE
    ;;
    ex)
    printf "Exiting!\n\n"
    ;; 
    esac
    sleep 3
}




while [ "$CHOICE" != "ex" ]
do
    menu_print
    read CHOICE
    menu_select
    
done
