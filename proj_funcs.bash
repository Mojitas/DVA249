#!/bin/bash


enter_continue()
{
    printf "\nPress any key to continue"
    read -s -n 1 key
}

user_add()
{
    printf "Enter name of the new user: "
    read USER_NEW
    adduser $USER_NEW
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
    read USER_ATTR
    cat /etc/passwd | grep $USER_ATTR | awk -F: '{print "\nUser name: " $1"\nUser id: "$3"\nPrimary group: "$4"\nUser comments: "$5"\nHome directory: "$6"\nShell: " $7}'
    echo "Secondary groups: "
    cat /etc/group | grep $USER_ATTR | awk -F: '{print $4}'
    enter_continue
}

user_mod()
{
    printf "Enter user that you wish to change: "
    read USER_NM

    echo -e "${RED}un${NC} - change username"
    echo -e "${RED}pw${NC} - change password"
    echo -e "${RED}pg${NC} - change primary group"
    echo -e "${RED}uc${NC} - change user comments"
    echo -e "${RED}hd${NC} - change home directory"
    echo -e "${RED}ds${NC} - change default shell"

    printf "Choice: "
    read USER_CH

    case $USER_CH in

        un)
            printf "Enter new username: "
            read USER_NM_NEW
            usermod -l $USER_NM_NEW $USER_NM 
            mv /home/$USER_NM /home/$USER_NM_NEW
            usermod -d /home/$USER_NM_NEW $USER_NM_NEW
            enter_continue
        ;;
        pw)
            passwd $USER_NM
        ;;
        pg)
            printf "Enter new primary group: "
            read USER_PMG
            usermod -g $USER_PMG $USER_NM
        ;;
        uc)
            printf "Enter new string: "
            read USER_COM
            usermod -c $USER_COM $USER_NM
        ;;
        hd)
            printf "Enter new existing home directory: "
            read USER_HD
            usermod -d $USER_HD $USER_NM
        ;;
        ds)
        # get available shells (and remove comments)
        SHELLS=$( cat /etc/shells | grep -v "#")
        SHELLS=($SHELLS)
        #print available shells with a corresponding index 
        for i in ${!SHELLS[@]}; do
        echo -e "[$i]\t${SHELLS[$i]}"
        done

        read INDEX
        #change shell for chosen user
        usermod -s ${SHELLS[$INDEX]} $USER_NM
        enter_continue
        ;;
        *)
        echo "invalid option"
        sleep 1
        ;;
    esac
}

user_del()
{
    echo "Enter user to delete:"
    read USER_DEL
    userdel -r $USER_DEL
    enter_continue
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
    cat /etc/group | awk -F: '$3 > 999 {print  "id: "$3, $1}'
    enter_continue
}

group_view()
{
    printf "Enter a group to list users in: "
    read GRP_USER
    printf "Secondary users in $GRP_USER: "
    grep $GRP_USER /etc/group | awk -F: '$3 > 999 {print $4}'
    enter_continue
}

group_mod()
{
    echo "Do you want to add or remove a user from a group?"
    echo -e "${RED}ad${NC} - Add user to group"
    echo -e "${RED}rm${NC} - remove user from group"
    printf "Choice: "
    read GRP_CHOICE

    case $GRP_CHOICE in

    ad)
        printf "Enter user to add: "
        read USER_ADD
        printf "Enter group to add user to: "
        read GRP_ADD
        gpasswd -a $USER_ADD $GRP_ADD
    ;;

    rm)
        printf "Enter user to remove: "
        read USER_RM
        printf "Enter group to remove user from: "
        read GRP_RM
        gpasswd -d $USER_RM $GRP_RM
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
    ls -a --color=auto $FLDR_LIST
    enter_continue
}

folder_view()
{
    printf "Select folder to view: "
    read FLDR
    ls -la --color=auto $FLDR | grep " \.$"
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
