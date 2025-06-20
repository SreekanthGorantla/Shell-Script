#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Error:: You must have sudo access to execute this command"
    exit 1 # other than 0
fi

dnf list installed mysql

if [ $? -ne 0 ] # If not installed
then
    dnf install mysql -y
    if [ $? -ne 0 ]
    then
        echo "Installing MySQL ...FAILURE"
        exit 1
    else
        echo "Installling MySQL ... SUCCESS"
    fi
else
    echo "MySQL is already ... INSTALLED"
fi


# if [ $? -ne 0 ]
# then
#     echo "Installing MySQL ...FAILURE"
#     exit 1
# else
#     echo "Installling MySQL ... SUCCESS"
# fi

dnf list installed git

if [ $? -ne 0 ]
then
    dnf install git -y
    if [ $? -ne 0 ]
    then
        echo "Installing Git ... FAILURE"
        exit 1
    else
        echo "Installing Git ... SUCCESS"
    fi
else
    echo "Git is already ... INSTALLED"
fi

# if [ $? -ne 0 ]
# then
#     echo "Installing Git ... FAILURE"
#     exit 1
# else
#     echo "Installing Git ... SUCCESS"
# fi