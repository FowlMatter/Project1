#!/bin/bash

echo " "
echo "System Audit Script"
echo " "
echo "Lets Display Today's Date"
date
echo " "
echo "What is This Machine's 411"
echo $MACHTYPE
echo " "
echo "The Basic 411 About Machine and O/S"
echo " "
echo -e "Uname info: $(uname -a) \n"
echo " "
echo -e "IP Info: $(ip addr | head -9 | tail -1) \n"
echo " "
echo "The Hostname Is:"
echo " "
echo "Hostname: $(hostname -s) "
echo " "
echo " The DNS Servers are :"
echo " "
cat /etc/resolv.conf
echo " "
echo "Here Is The Memory Info:"
free
echo " "
echo "CPU usage is:"
lscpu
echo " "
echo "The Disk Usage Is:"
df -H | head -5
# more elegant than "df -H"  pipes output of first 5 disks to Head to reduce extraneous output
echo " "
echo " Who is Currently Logged In"
echo " "
who
echo " "
echo "This is the end of this script"
echo " Woo-Hoo"
