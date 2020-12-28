#!/bin/bash

export TERM=${TERM:-dumb}
export TERM=xterm-256color

source proj_funcs.bash # Functions from an other script
source proj_menu.bash # Menu functions

###############################Functions#################################

menu_select()
{
    clear
    case $CHOICE in

    ni)  # display network info
    func    
    ;;
    ua)  # user add
    echo $CHOICE
    ;;
    ul) #user list
    echo $CHOICE
    ;;
    uv) #user view
    echo $CHOICE
    ;;
    um) # user modify
    echo $CHOICE
    ;;
    ud) #user delete
    echo $CHOICE
    ;;
    ga) # group add
    echo $CHOICE
    ;;
    gl) #group list
    echo $CHOICE
    ;;
    gv) #group view
    echo $CHOICE
    ;;
    gm) #group modify
    echo $CHOICE
    ;;
    gd) #group delete
    echo $CHOICE
    ;;
    fa) #folder add
    printf "Enter a name for a folder to add: "
    read FLDR_NAME
    mkdir $FLDR_NAME

    ;;
    fl) #folder list
    echo $CHOICE
    ;;
    fv) #folder view
    echo $CHOICE
    ;;
    fm) #folder modify
    echo $CHOICE
    ;;
    fd) #folder delete
    echo $CHOICE
    ;;
    ex) #exit
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
