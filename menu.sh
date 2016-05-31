#!/bin/bash

#Variables
ROOTPATH=/Config-Services-master

# Assign IP Address
Assign_IP(){
read -r -p "Are you sure to Assign IP Address? [Y/n] " input
case $input in
    [yY][eE][sS]|[yY])
                clear
                ./$ROOTPATH/assign-ip.sh
                ;;

    [nN][oO]|[nN])
                echo "No"
                ;;

    *)
        echo "Please choice Y/n"
        Assign_IP
        ;;
esac
}

#Install DNS
Install_Dns(){
read -r -p "Are you sure to install DNS? [Y/n] " input
case $input in
    [yY][eE][sS]|[yY])
                clear
                ./$ROOTPATH/dns-bind.sh
                ;;

    [nN][oO]|[nN])
                echo "No"
                ;;

    *)
        echo "Please choice Y/n"
        Install_Dns
        ;;
esac
}
# function to display menus
show_menus(){
        clear
        echo " _____________________________________________ "
        echo "|                                             |"
        echo "|              M A I N - M E N U              |"
        echo "|---------------------------------------------|"
        echo "|    Author : LuanPham                        |"
        echo "|    Website : http://www.adminvietnam.org    |"
        echo "|_____________________________________________|"
        echo""
        echo "1. Config Static IP address " 
        echo "2. Install DNS Server "
        echo "3. Install Web Server"
        echo "4. Install_Mail"
        echo "5. Exit"
}
read_options(){
        local choice
        read -p "Enter choice [ 1 - 5] " choice
        case $choice in
                1) Assign_IP ;;
                2) Install_Dns ;;
                3) Install_Web ;;
                4) Install_Mail ;;
                5) exit 0;;
                *) echo -e "please choose 1 - 9" && sleep 2
        esac
}

while true
do

        show_menus
        read_options
done
