#!/bin/bash

#While re-creating all these linux scripts I read and relied heavily upon student
#activity files and solved activity files, all lecture guides and Google.

# Check for output variable zombie. Save as backup to clear.
if [ -f $output ]; then
  mv $HOME/research/sys_info.txt sys_info.bak
fi
echo " "
# Check for research directory. Create it if needed.
if [ ! -d $HOME/research ]; then
  mkdir $HOME/research
fi
echo " "
# Define Variables
output=$HOME/research/sys_info.txt
SecFiles=('/etc/passwd' '/etc/shadow')
ip=$(ip addr | head -9 | tail -1 ) 
execs=$(sudo find /home -type f -perm 777 2>/dev/null)
commands=(
        'date'
        'uname -a'
        'hostname -s'
)
echo "output date, all usernames, and the hostname to $output"
for x in {0..2}
do
        results=$(${commands[$x]})
        echo "The results of \"${commands[$x]}\" command are:"
        echo "$results" >> $output
        echo " "
done


#They check if script was run as root. Exit if true.
#if [ $UID -eq 0 ]; then
#  echo "Please do not run this script as root."
#  exit
#fi

echo "Send IP and exec info to output file"
echo -e "IP Info:" >> $output
echo -e "$ip \n" >> $output
echo " "
echo "Let's define where the passwd and shadow files are and"
echo "combine them to determine people (user) permissions"
echo " "
echo "What are our people's permissions"
# Define people in SecFiles 
for people in ${SecFiles[@]}
# List user and permissions into output file of all user permissions
do
        ls -l $people >> $output
done
echo " "
echo "Let's find all users in the home directory"
echo "with sudo permissions"
echo "One way is execute sudo with each user"
echo "in home directory and verify results"
for user in $(ls /home)
do
        sudo -lU $user >> $output
done
echo " "
echo "This command can be executed from the command line as"
echo "for user in $(ls /home); do sudo -lU $user; done"
echo " "
echo "System Audit Script"
echo " "
echo "Let's Make A Directory For Our Research"
echo " "
mkdir ~/research 2> /dev/null
echo " "
echo "Lets Display Today's Date"
date >> $output
echo " "
echo "What is This Machine's 411"
echo $MACHTYPE >> $output
echo " "
echo "The Basic 411 About Machine and O/S"
echo " "
echo -e "Uname info: $(uname -a)" >> $output
echo " "
echo -e "IP Info: $(ip addr | head -9 | tail -1)" >> $output
echo " "
echo "The Hostname Is:"
echo " "
echo "Hostname: $(hostname -s)" >> ~/research/sys_info.txt
echo " "
echo " The DNS Servers are :"
echo " "
cat /etc/resolv.conf >> ~/research/sys_info.txt
echo " "
echo "Here Is The Memory Info:"
free >> $output
echo " "
lscpu >> $output
echo " "
echo "The Disk Usage Is:"
df -H | head -5 >> $output
# more elegant than my "df -H"  pipes output of 1st 5 disks to Head to reduce extraneous output 
echo " "
echo " Who is Currently Logged In"
echo " "
who >> $output
echo " "
echo "This is the end of this script"
echo " Woo-Hoo"
echo " "
echo " "
echo "Not So Fast Kid"
echo "There's More..."
echo " "
echo "Let's Find Some Wide Open 777 Files"
echo " "
find -type f -perm 777 >> $output
echo " "
echo "Your Top 10 Processes"
ps aux -m | awk {'print $1, $2, $3, $4, $11'} | head >> $output