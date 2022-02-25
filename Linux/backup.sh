#!/bin/bash

#############################
#                           #
#  MUST BE RUN AS ROOT!!!   #
#                           #
#############################

#make backup directory
mkdir -p /var/backup

#Create tar file in /var/backup directory
tar -cvvf /var/backup/home_"$(date '+%F')".tar /home


