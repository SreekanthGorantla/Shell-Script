#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"

VALIDATE(){
     if [ $1 -ne 0 ]
    then
        echo -e "$2 ... $R FAILURE"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS"
    fi
}

if [ $USERID -ne 0 ]
then
    echo "Error:: You must have sudo access to execute this command"
    exit 1 # other than 0
fi

dnf list installed mysql

if [ $? -ne 0 ] # If not installed
then
    dnf install mysql -y
    VALIDATE $? "Installing MySQL"
else
    echo -e "MySQL is already ... $Y INSTALLED"
fi

dnf list installed git

if [ $? -ne 0 ]
then
    dnf install git -y
    VALIDATE $? "Installing Git"
else
    echo -e "Git is already ... $Y INSTALLED"
fi


# color codes in shell script
# Code	Color/Style
# 0	Reset / Normal
# 1	Bold
# 4	Underline
# 30	Black text
# 31	Red text
# 32	Green text
# 33	Yellow text
# 34	Blue text
# 35	Magenta text
# 36	Cyan text
# 37	White text
# 40	Black background
# 41	Red background
# 42	Green background
# 43	Yellow background
# 44	Blue background
# 45	Magenta background
# 46	Cyan background
# 47	White background

# To print required color to the test is \e[31m
# Example: echo -2 "\e[31m HelloWorld" 