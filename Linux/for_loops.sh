#!/bin/bash

#name the variables
states=('Oregon' 'Californiia' 'Hawaii' 'Washington' 'New York')

#Define the for statement and launch if/then loop serching for Hawaii
for state in ${states[@]}
do

        if [ $state == 'Hawaii' ];
        then
          echo " Hawaii is the best!
        else
          echo "I'm not fond of Hawaii"
        fi
done

#name the varaible
numbers=$(echo{0..9})

#Define the for statement and launch if/then loop to find 3, 5, or 7
for number in ${numbers[@]}
do
          if [ $number  = 3 ] || [ $number = 5 ] || [ $number = 7 ]
        then
          echo $number

          fi
done

#name the variable
ListOut=$(ls)
#Define for loop to echo out all varibles in ListOut (ls seems easier ;-)
for n in ${ListOut[@]}
do
        echo $n
done

#name the variable
execs=$(find /home -type f -perm 777 2> /dev/null)

#Define the loop to output all exec in execs variable
for exec in ${execs[@]}
do
        echo $exec
done
