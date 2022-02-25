#!/bin/bash

#This script will clean up temporary files, thumbnails and apt cache
#First, we clear out the tmp directories
rm -rf /tmp/*  /var/tmp/*

#Then we clean the apt cache
apt clean -y

#Now we remove the thumbnails from all users in home directory
rm -rf /home/sysadmin/.cache/thumbnails
rm -rf /home/.cache/thumbnails
rm -rf /root/.cache/thumbnails
rm -rf /home/instructor/.cache/thumbnails

#All in One!
rm -rf /tmp/*  /var/tmp/* /home/sysadmin/.cache/thumbnails /home/.cache/thumbnails /root/.cache/thumbnails /home/instructor/.cache/thumbnails apt clean -y