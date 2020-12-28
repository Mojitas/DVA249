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
    printf "Enter the name of the new group: "
    read GRP_NAME
    groupadd $GRP_NAME
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
    folder_add
    ;;

    fl) #folder list
    echo "You are in $PWD"
    printf "Select folder to list content in: "
    read FLDR_LIST
    ls -la --color=auto $FLDR_LIST
    printf "\nPress enter to continue"
    read -s -n 1 key
    ;;

    fv) #folder view
    printf "Select folder to view: "
    read FLDR
    ls -l | grep $FLDR
    printf "\nPress enter to continue"
    read -s -n 1 key
    ;;

    fm) #folder modify
    echo "You are in $PWD"
    printf "Select folder to change permissions on: "
    read FLDR
    echo $FLDR has permissions: 
    ls -l | grep $FLDR
    printf "Enter new permission: "
    read FLDR_PERM
    chmod $FLDR_PERM $FLDR
    printf "\nPress enter to continue"
    read -s -n 1 key
    ;;

    fd) #folder delete
    echo "You are in $PWD"
    printf "Select folder to delete: "
    read FLDR_DEL
    rm -r $FLDR_DEL
    ;;
    ex) #exit
    printf "Exiting!\n\n"
    ;; 
    esac
    
}


cd /home/mojitas


while [ "$CHOICE" != "ex" ]
do
    menu_print
    read CHOICE
    menu_select
    
done
