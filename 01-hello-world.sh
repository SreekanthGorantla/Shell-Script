#!/bin/bash

# echo "Hello World!"
# echo "Hi World!"

# echo "how is the world!"

a=0
while [ "$a" -lt 10 ];
do
    b="$a"
    while [ "$b" -ge 0 ];
    do
        echo -n "$b "
        b=$(expr $b - 1)
    done
    echo
    a=$(expr $a + 1)
done

