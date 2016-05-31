#!/bin/bash

#Variables
ROOTPATH=/Config-Services-master/

#clear
#INSTALL="yum -y -q install"
#echo -n "Installing wget .........."; $INSTALL wget &> $NULL; echo " done.";
#echo -n "Downloading from GitHub.........."; wget https://github.com/luanpmadvn/Config-Services/archive/master.zip --no-check-certificate -P / ; echo " done.";
#echo -n "Extracting master.zip........."; unzip /master ; echo "done.";
#chmod 777 -R /Config-Services-master/


# Assign IP Address
Assign_IP(){
read -r -p "Are you sure to Assign IP Address? [Y/n] " input
case $input in
    [yY][eE][sS]|[yY])
                ./$ROOTPATH/assign-ip.sh
                ;;

    [nN][oO]|[nN])
                echo "No"
                ;;

    *)
        echo "Invalid input..."
        Assign_IP
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
