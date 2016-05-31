#!/bin/bash

#Variable
ROOTPATH=/etc/sysconfig/network-scripts/ifcfg
NULL=/dev/null

function pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

# This Scripts to assign IP addreess
clear
read -p "Which interface do you want assign IP address? :  " INTERFACE
MAC=$(ifconfig $INTERFACE | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')
read -p "Enter IP address for $INTERFACE: " IPADDR
read -p "Enter Netmask: " NETMASK
read -p "Enter Gateway: " GATEWAY
echo -n "Remove old file......"; rm -f $ROOTPATH-$INTERFACE	&> $NULL; echo "done.";
echo -n "Creating new file......"; touch $ROOTPATH-$INTERFACE &> $NULL; echo "done.";
echo "DEVICE=$INTERFACE" >> $ROOTPATH-$INTERFACE
echo "ONBOOT=yes" >> $ROOTPATH-$INTERFACE
echo "NM_CONTROLLED=yes" >> $ROOTPATH-$INTERFACE
echo "BOOTPROTO=static" >> $ROOTPATH-$INTERFACE
echo "HWADDR=$MAC" >> $ROOTPATH-$INTERFACE
echo "IPADDR=$IPADDR" >> $ROOTPATH-$INTERFACE
echo "NETMASK=$NETMASK" >> $ROOTPATH-$INTERFACE
echo "GATEWAY=$GATEWAY" >> $ROOTPATH-$INTERFACE
echo "DNS1=8.8.8.8" >> $ROOTPATH-$INTERFACE

echo -n "Restarting network......"; service network restart &> $NULL; echo "done."; pause;


