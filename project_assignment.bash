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
        enter_continue
    ;;
    gl) #group list
        echo "Groups:"
        cat /etc/group | awk -F: '$3 > 999 {print $3, $1}'
        enter_continue
    ;;
    gv) #group view
        printf "Enter a group to list users in: "
        read GRP_USER
        grep $GRP_USER /etc/group | awk -F':' '{print $4}'
        enter_continue
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
        folder_list
    ;;

    fv) #folder view
        folder_view
    ;;

    fm) #folder modify
        folder_mod
    ;;

    fd) #folder delete
        folder_del
    ;; 
    ex)
        echo "Exiting!"
        sleep 1
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
