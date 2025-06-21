#!/bin/bash

# NUMBER=$1
# # -gt(greater than), -lt(less than), -ge(greater than eauals), -le
# if [ $NUMBER -gt 100 ]
# then
#     echo "Given number is greater than 100"
# else
#     echo "Given number is less than or equal to 100"
# fi

echo "What is today of a week? "
read WEEK
if [ "$WEEK" -ne "sunday" ]
then
    echo "You have to go to School."
else
    echo "Today is holiday. No School."
fi