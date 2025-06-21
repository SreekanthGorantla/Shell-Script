#!/bin/bash

USERID=$(id -u)         # Check user id
# Colours to the text
R="\e[31m"  # Red color
G="\e[32m"  # Green color
Y="\e[33m"  # Yellow color
N="\e[0m"   # No color and this helps to stop previous color to continue and brings back to original color

LOGS_FOLDER="/var/log/shellscript-logs"     # Give the folder path where you want to store the log file
LOG_FILE=$(echo $0 |cut -d "." -f1)         # Log file format with seperater 
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)        # Time stamp which will provide date and time with seconds
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"   # Log file name using above 3 values whcih stores the logs

# Validate function whether it is success or failure
VALIDATE(){
     if [ $1 -ne 0 ]    # It is the condition whether $1 not equels to 0(Zero) or not
    then
        echo -e "$2 ... $R FAILURE $N"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N"
    fi
}

echo "Script started executing at: $TIMESTAMP" &>> $LOG_FILE_NAME

if [ $USERID -ne 0 ]    # Here this will check the access before executing packages
then
    echo "Error:: You must have sudo access to execute this command"
    exit 1 # other than 0
fi

for package in $@
do
    dnf list installed $package &>>$LOG_FILE_NAME
    if [ $? -ne 0 ]
    then
        dnf install $package -y &>>$LOG_FILE_NAME
        VALIDATE $? "Installing $package"
    else
        echo -e "$package is already $Y ... INSTALLED $N"
    fi
done

# sh 15-loops.sh git nginx mysql gcc etc.. 