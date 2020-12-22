#!/bin/bash

menu_print()
{
    RED='\e[31m'
    NC='\e[0m'
    TRUE=1

    clear
    echo "****************************************************************"
    echo "                    SYSTEM MANAGER (ver 1.1)"
    echo "----------------------------------------------------------------"     
    echo -e "${RED}ni${NC} - Network Info  (Network information)"
    echo
    echo -e "${RED}ua${NC} - User Add      (Create a new user)"
    echo -e "${RED}ul${NC} - User List     (List all login users)"
    echo -e "${RED}uv${NC} - User View     (View user properties)"
    echo -e "${RED}um${NC} - User Modify   (Modify User properties)"
    echo -e "${RED}ud${NC} - User Delete   (Deleta a login user)"
    echo
    echo -e "${RED}ga${NC} - Group Add     (Create a new group)"
    echo -e "${RED}gl${NC} - Group List    (List all groups, not system groups)"
    echo -e "${RED}gv${NC} - Group View    (List all user in a group)"
    echo -e "${RED}gm${NC} - Group modify  (Add/remove user to/from a group)"
    echo -e "${RED}gd${NC} - Group Delete  (Delete a group, not system groups)"
    echo
    echo -e "${RED}fa${NC} - Folder Add    (Create a new folder)"        
    echo -e "${RED}fl${NC} - Folder List   (View content in a folder)"
    echo -e "${RED}fv${NC} - Folder View   (View folder properties)"
    echo -e "${RED}fm${NC} - Folder Modify (Modify folder properties)"
    echo -e "${RED}fd${NC} - Delete Folder (Delete a folder)"
    echo
    echo -e "${RED}ex${NC} - Exit          (Exit System Manager)"
    echo "----------------------------------------------------------------"
    printf 'Choice: '  
}
