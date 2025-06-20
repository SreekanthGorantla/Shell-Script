#!/bin/bash

# echo "Hello World!"
# echo "Hi World!"

# echo "how is the world!"

# a=0
# while [ "$a" -lt 10 ];
# do
#     b="$a"
#     while [ "$b" -ge 0 ];
#     do
#         echo -n "$b "
#         b=$(expr $b - 1)
#     done
#     echo
#     a=$(expr $a + 1)
# done

for ((a=0; a<10; a++)); 
do
    for ((b=a; b>=0; b--)); 
    do
        echo -n "$b "
    done
    echo
done