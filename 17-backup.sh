#!/bin/bash

#Give colours to the output
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} # if user is not providing number of days we are taking 14 days as default

LOGS_FOLDER="/var/log/backup-logs"
LOG_FILE=$(echo $0 |cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

# VALIDATE(){
#     if [ $1 -ne 0 ]
#     then
#         echo -e "$2 ... $R FAILURE $N"
#         exit 1
#     else
#         echo -e "$2 ... $G SUCCESS $N"
#     fi
# }

USAGE(){
    echo -e "$R USAGE:: $N sh 17-backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS(optional)>"
    exit 1
}

if [ $# -lt 2 ]
then
    USAGE
fi

if [ ! -d $SOURCE_DIR ]
then
    echo -e "$SOURCE_DIR does not exist...Please check"
    exit 1
fi

if [ ! -d $DEST_DIR ]
then
    echo -e "$DEST_DIR does not exist...Please check"
    exit 1
fi

mkdir -p $LOGS_FOLDER
echo "Script started executing at: $TIMESTAMP" &>> $LOG_FILE_NAME

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

echo "Files are: $FILES"

if [ -n "$FILES" ] #True if there are files to Zip
then
    echo "Files are: $FILES"
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ "$ZIP_FILE"
    if [ -f "$ZIP_FILE" ]
    then
        echo -e "Successfully created Zip file for files olderthan $DAYS"
        while read -r file #File is a variable name. U can give any name
        do
            echo "Deleting file: $file" &>> $LOG_FILE_NAME
            rm -rf $file
            echo "Deleted file: $file"
        done <<< $FILES_TO_DELETE
    else
        echo -e "$R Error:: $N Failed to create Zip file"    
        exit 1
    fi
else
    echo "No files found olderthan $DAYS"
fi