#!/bin/bash


enter_continue()
{
    printf "\nPress enter to continue"
    read -s -n 1 key
}


group_mod()
{
    echo "Do you want to add or remove a user from a group?"
    echo "ad - Add user to group"
    echo "rm - remove user from group"
    printf "Choice: "
    read GRP_CHOICE

    case GRP_CHOICE in

    ad)
    printf "Enter user to add: "
    read USR_ADD
    printf "Enter group to add user to: "
    read GRP_ADD

    gpasswd -a $USR_ADD $GRP_ADD
    ;;
    rm)
    printf "Enter user to remove: "
    read USR_RM
    printf "Enter group to remove user from: "
    read GRP_RM
    gpasswd -d $USR_RM $GRP_RM
    ;;
    *)
    echo "Not an option!"
    ;;
}

group_del()
{
    printf "Enter group to delete: "
    read GRP_DEL
    groupdel $GRP_DEL
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
