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
    echo -e "${RED}Users${NC}:"
    cat /etc/passwd | awk -F: '$3 > 999 {print $3, $1}'
    enter_continue
}

user_view()
{
    printf "Enter user to list attributes about: "
    read USER_ATTR
    clear
    echo -e "${RED}User info${NC}: "
    cat /etc/passwd | grep $USER_ATTR | awk -F: '{print "User name: " $1"\nUser id: "$3"\nPrimary group: "$4"\nUser comments: "$5"\nHome directory: "$6"\nShell: " $7}'
    echo -e "\n${RED}All groups${NC}: "
    cat /etc/group | grep $USER_ATTR | awk -F: '{print $1, "ID: " $3}'
    enter_continue
}

user_mod()
{
    printf "Enter user that you wish to change: "
    read USER_NM

    echo -e "${RED}un${NC} - Change username"
    echo -e "${RED}pw${NC} - Change password"
    echo -e "${RED}pg${NC} - Change primary group"
    echo -e "${RED}uc${NC} - Change user comments"
    echo -e "${RED}hd${NC} - Change home directory"
    echo -e "${RED}ds${NC} - Change default shell"
    echo -e "${RED}rt${NC} - Return to main menu"

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
        rt)
        echo "Return to main menu"
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
    echo -e "${RED}Groups${NC}:"
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
    echo -e "${RED}rm${NC} - Remove user from group"
    echo -e "${RED}rt${NC} - Return to main menu"
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

    rt)
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
    echo "You are in $PWD"
    printf "Select folder to view: "
    read FLDR
    #ls -la --color=auto $FLDR | grep " \.$"

    # DIRSTATS format: <numeric permissions> <name> <owner user name> <owner group name>
    DIRSTATS=( $(stat -c "%#a %U %G" $FLDR) )
    DIRPERM=${DIRSTATS[0]}
    DIRNAME=$(stat -c "%n" $FLDR)

    echo DIRPERM $DIRPERM

    echo "Folder $DIRNAME"
    echo "Permissions:"
    echo "User ${DIRSTATS[1]}:"
    #check user permissions (bitshift numerical permissions by 6)
    #if 0Z00 then
    PERM=$((DIRPERM>>6))
    check_octal_permissions

    echo -e "\nGroup ${DIRSTATS[2]}:"
    #check group permissions
    PERM=$((DIRPERM>>3))
    check_octal_permissions
    
    echo -e "\nOther:"
    #check Other permissions
    PERM=$((DIRPERM>>0))
    check_octal_permissions 

    if (( $DIRPERM & 8#7000 )) 
    then
        echo "Additional permissions:"
    fi

    #if 1000 then bit is sticky
    if (( $DIRPERM>>9 & 1 )) 
    then
        echo -n "Sticky bit"
    fi

    #if 2000 then SetGID true
    if (( $DIRPERM>>9 & 2 )) 
    then
        echo -n "SetGID"
    fi

    enter_continue

}

check_octal_permissions()
{
    if (( $PERM & 4 ))
    then
        echo -n -e "\tRead"
    fi
    if (( $PERM & 2 )) 
    then
        echo -n -e "\tWrite"
    fi
    if (( $PERM & 1 )) 
    then
        echo -n -e "\tExecute"
    fi
}

folder_mod()
{
    echo "You are in $PWD"
    printf "Select folder to change permissions on: "
    read FLDR
    echo $FLDR has permissions: 
    ls -la --color=auto $FLDR | grep " \.$"
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
