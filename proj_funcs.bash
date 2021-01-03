#!/bin/bash


enter_continue()
{
    printf "\nPress any key to continue"
    read -s -n 1 key
}

user_add()
{
    printf "Enter name of the new user: "
    read USR_NEW
    adduser $USR_NEW
}

user_list()
{
    echo "Users:"
    cat /etc/passwd | awk -F: '$3 > 999 {print $3, $1}'
    enter_continue
}

user_view()
{
    printf "Enter user to list attributes about: "
    read USR_ATTR
    cat /etc/passwd | grep $USR_ATTR | awk -F: '{print "\nUser name: " $1"\nUser id: "$3"\nPrimary group: "$4"\nUser comments: "$5"\nHome directory: "$6"\nShell: " $7}'

    enter_continue
}

user_mod()
{
    printf "Enter user that you wish to change: "
    read USER_NM

    echo "un - change username"
    echo "ps - change password"
    echo "pm - change primary group"
    echo "uc - change user comments"
    echo "hd - change home directory"
    echo "sh - change default shell"

    printf "Choice: "
    read USR_CH

    case $USER_CH in

        un)
        printf "Enter new username: "
        read USR_NM_NEW
        usermod -l $USER_NM_NEW $USER_NM 
        ;;
        ps)
        passwd $USER_NM
        ;;
        pm)
        printf "Enter new primary group: "
        read USR_PMG
        usermod -g $USR_PMG $USER_NM
        ;;
        uc)
        printf "Enter new string: "
        read USR_COM
        usermod -c $USR_COM $USR_NM
        ;;
        hd)
        printf "Enter new existing home directory: "
        read USR_HD
        usermod -d USR_HD USR_NM
        ;;
        sh)
        ;;
        *)
        ;;
    esac
}

user_del()
{
    echo "to be added"
}

group_add()
{
    printf "Enter the name of the new group: "
    read GRP_NAME
    groupadd $GRP_NAME
    enter_continue
}

group_list()
{
    echo "Groups:"
    cat /etc/group | awk -F: '$3 > 999 {print $3, $1}'
    enter_continue
}

group_view()
{
    printf "Enter a group to list users in: "
    read GRP_USER
    grep $GRP_USER /etc/group | awk -F':' '{print $4}'
    enter_continue
}

group_mod()
{
    echo "Do you want to add or remove a user from a group?"
    echo "ad - Add user to group"
    echo "rm - remove user from group"
    printf "Choice: "
    read GRP_CHOICE

    case $GRP_CHOICE in

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
    esac
    enter_continue
}

group_del()
{
    printf "Enter group to delete: "
    read GRP_DEL
    groupdel $GRP_DEL
    enter_continue
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
    printf "Exiting!\n\n"
}
