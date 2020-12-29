#!/bin/bash


enter_continue()
{
    printf "\nPress enter to continue"
    read -s -n 1 key
}

folder_add()
{
    echo "You are in $PWD"
    printf "Enter a name for a folder to add: "
    read FLDR_NAME
    mkdir $FLDR_NAME
}

folder_list()
{
    echo "You are in $PWD"
    printf "Select folder to list content in: "
    read FLDR_LIST
    ls -la --color=auto $FLDR_LIST
    enter_continue
}

folder_view()
{
    printf "Select folder to view: "
    read FLDR
    ls -l | grep $FLDR
    enter_continue
}


folder_mod()
{
    echo "You are in $PWD"
    printf "Select folder to change permissions on: "
    read FLDR
    echo $FLDR has permissions: 
    ls -l | grep $FLDR
    printf "Enter new permission: "
    read FLDR_PERM
    chmod $FLDR_PERM $FLDR
    enter_continue
}

folder_del()
{
    echo "You are in $PWD"
    printf "Select folder to delete: "
    read FLDR_DEL
    rm -r $FLDR_DEL
    ;;
    ex) #exit
    printf "Exiting!\n\n"
}
