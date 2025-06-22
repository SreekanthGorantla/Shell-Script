#!/bin/bash

USERID=$(id -u)

#colours to use if needed
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FOLDER="path"
LOG_FILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOG_FOLDER/$LOG_FILE-$TIMESTAMP.LOG"

#Create Validate function

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 ... $R FAILURE $N"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N"
    fi
}

CHECK_ROOT(){
if [ $USERID -ne 0 ]
then
    echo "Error:: You must have suco access to execute this command"
    exit 1
fi
}

mkdir -p $LOG_FOLDER

echo "Script started executing at: $TIMESTAMP" &>> $LOG_FILE_NAME

CHECK_ROOT

for package in $@
do
    dnf list installed $package &>> $LOG_FILE_NAME
    if [ $? -ne 0 ]
    then
        dnf install $package -y &>> $LOG_FILE_NAME
        VALIDATE $? "Installed $package"
    else
        echo -e "$package is already $Y ... INSTALLED $N"
    fi
done