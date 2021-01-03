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

<<<<<<< ours
    ni)
#    func    
    bash temp/networkinfo
    ;;
    ua)
    echo $CHOICE
    ;;
    ul)
    echo $CHOICE
=======
    ni)  # display network info
        echo "network stuff!"
        enter_continue
    ;; 
    ua)  # user add
        user_add
>>>>>>> theirs
    ;;
    ul) # user list
        user_list
    ;;
    uv) # user view
        user_view
    ;;
    um) # user modify
        user_mod
    ;;
    ud) # user delete
        user_del
    ;;
    ga) # group add
        group_add
    ;;
    gl) #group list
        group_list
    ;;
    gv) #group view
        group_view
    ;;
    gm) #group modify
        group_mod       
    ;;
    gd) #group delete
        group_del
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
    esac
}


cd /home/mojitas


while [ "$CHOICE" != "ex" ]
do
    menu_print
    read CHOICE
    menu_select
    
done
