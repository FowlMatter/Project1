#!/bin/bash

######################
#                                     #
# Must Be Run As Sudo   #
#                                     #
######################

# This script will do update on all installed packages
# It will first update the apt library
apt update -y
# then upgrade installed
apt upgrade -y 
# Then install new packages and uninstall old packages
apt full-upgrade -y 
# Now we remove obsolete files and configurations
apt autoremove --purge -y
#The above command was from student solutions week 5 update.sh

#Run them all in a single line by daisy chaining them
#apt update -y && apt upgrade -y && apt full-upgrade -y && apt autoremove --purge -y