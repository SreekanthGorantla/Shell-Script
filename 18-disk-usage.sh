#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
DISK_THRESSHOLD=5
MSG=""

while read -r line
do
    USAGE=$(echo $line | awk -F " " '{print $6F}'  | cut -d "%" -f1)
    PARTITION=$(echo $line | awk -F " " '{print $NF}')
    #echo "Partition: $PARTITION , Usage: $USAGE"
    if [ $USAGE -ge $DISK_THRESSHOLD ]
    then
        MSG+="High Disk usage on partition: $PARTITION Usage is: $USAGE \n"
    fi
done <<< $DISK_USAGE

echo -e "Message: $MSG"

#echo "$MSG" | sendmail/mutt -s "High Disk Usage" <email>

#Cron setup
#PATH=/usr/bin:/bin:/usr/local/bin