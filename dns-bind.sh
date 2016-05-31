#!/bin/bash
# This scripts to auto install DNS server use BIND

# Information System's
HOST=$(hostname)
ROOTPATH=/Config-Services-master
IP=$(/sbin/ifconfig eth0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')
OCTET=$(IP=$(/sbin/ifconfig eth0 | grep 'inet addr' | cut -d. -f4 | awk '{print $1}'))
NETMASK=$(/sbin/ifconfig eth0 | grep 'inet addr' | cut -d: -f4 | awk '{print $1}')
GATEWAY=$(/sbin/ip route | awk '/default/ { print $3 }')

function pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

read -p "Enter your domain name: " DOMAIN
read -p "Enter your server name: " SERVERNAME
read -p "Enter reverse zone(ex.1.168.192): " REVERSE
echo""
echo -n "Installing bind .........."; yum -y -q install bind* &> /dev/null; echo " done.";
rpm -qa bind*

# Remove
rm -f /etc/named.conf

# Copy
cp -r $ROOTPATH/named.conf /etc/named.conf
cp -r $ROOTPATH/0.0.127.db /var/named/0.0.127.db
cp -r $ROOTPATH/localhost.db /var/named/localhost.db
cp -r $ROOTPATH/congty.db /var/named/$DOMAIN.db
cp -r $ROOTPATH/1.16.172.db /var/named/$REVERSE.db
cp -r $ROOTPATH/named.root /var/named/named.root

# named.conf
sed -i -e "s/172.16.1.10/$IP/" /etc/named.conf
sed -i -e "s/congty.com/$DOMAIN/" /etc/named.conf
sed -i -e "s/congty.db/$DOMAIN.db/" /etc/named.conf
sed -i -e "s/1.16.172.in-addr.arpa/$REVERSE.in-addr.arpa/" /etc/named.conf
sed -i -e "s/1.16.172.db/$REVERSE.db/" /etc/named.conf

# congty.db
sed -i -e "s/server1.congty.com./$HOST./" /var/named/$DOMAIN.db
sed -i -e "s/server1/$SERVERNAME/" /var/named/$DOMAIN.db
sed -i -e "s/172.16.1.10/$IP/" /var/named/$DOMAIN.db

# 1.16.172.db
sed -i -e "s/server1.congty.com./$HOST./" /var/named/$REVERSE.db
sed -i -e "s/congty.com/$DOMAIN/" /var/named/$REVERSE.db
sed -i -e "s/10/$OCTET/" /var/named/$REVERSE.db
sed -i -e "s/server1/$SERVERNAME/" /var/named/$REVERSE.db
sed -i -e "s/172.16.1.10/$IP/" /var/named/$REVERSE.db

# Firewall
echo -n "Configuring Firewall.........."; iptables -A INPUT -m state --state NEW -m udp -p udp --dport 53 -j ACCEPT &> /dev/null; echo "done.";
echo -n "Saving configuration ........."; service iptables save &> /dev/null; echo "done.";
echo -n "Restating Firewall........."; service iptables restart &> /dev/null; echo "done.";

# Service
echo -n "Starting DNS.........."; service named start &> /dev/null; echo " done."; chkconfig named on; dig $DOMAIN; pause;

    
