#!/bin/bash -x

#RANDOM VALUE FOR HEADS AND TAIL
randomFlip=$((RANDOM%2))
if [ $randomFlip -eq 1 ]
then
	echo "Its a Head"
else
	echo "Its a Tail"
fi
